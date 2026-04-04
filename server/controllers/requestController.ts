import asyncHandler from 'express-async-handler';
import pool from '../database.ts';
import type { Request, Response } from 'express';
import type { PoolConnection, ResultSetHeader, RowDataPacket } from 'mysql2/promise';

type Status = 'pending' | 'approved' | 'rejected';

type OrganizationSummary = {
  orgId: number;
  name: string;
  website: string;
};

type ConferenceSeriesSummary = {
  seriesId: number;
  orgId: number;
  organization: string;
  name: string;
  acronym: string | null;
};

type SeriesYearSummary = {
  seriesId: number;
  years: number[];
};

type VenueInstancePayload = {
  existingSeriesId: number | null;
  existingOrgId: number | null;
  newOrganizationName: string;
  newOrganizationWebsite: string;
  newOrganizationSociety: string;
  newOrganizationPublisher: string;
  newOrganizationUniversity: string;
  newSeriesName: string;
  newSeriesAcronym: string;
  newSeriesDescription: string;
  typicalMonth: number | null;
  typicalCityPolicy: string;
  tier: string;
  year: number;
  title: string;
  startDate: string | null;
  endDate: string | null;
  city: string;
  country: string;
  submissionDeadline: string | null;
  cfpUrl: string;
  callForPapers: string;
};

type RequestRow = {
  requestId: number;
  submittedByUserId: number;
  submittedByName: string;
  reviewedByUserId: number | null;
  reviewedByName: string | null;
  createdAt: string;
  status: Status;
  requestType: string | null;
  payloadJson: unknown;
};

const parsePayload = (value: unknown): VenueInstancePayload => {
  if (!value) {
    throw new Error('Request payload is empty.');
  }

  const raw = typeof value === 'string' ? JSON.parse(value) : value;
  const payload = raw as Partial<VenueInstancePayload>;

  return {
    existingSeriesId: payload.existingSeriesId ?? null,
    existingOrgId: payload.existingOrgId ?? null,
    newOrganizationName: payload.newOrganizationName?.trim() ?? '',
    newOrganizationWebsite: payload.newOrganizationWebsite?.trim() ?? '',
    newOrganizationSociety: payload.newOrganizationSociety?.trim() ?? '',
    newOrganizationPublisher: payload.newOrganizationPublisher?.trim() ?? '',
    newOrganizationUniversity: payload.newOrganizationUniversity?.trim() ?? '',
    newSeriesName: payload.newSeriesName?.trim() ?? '',
    newSeriesAcronym: payload.newSeriesAcronym?.trim() ?? '',
    newSeriesDescription: payload.newSeriesDescription?.trim() ?? '',
    typicalMonth: payload.typicalMonth ?? null,
    typicalCityPolicy: payload.typicalCityPolicy?.trim() ?? '',
    tier: payload.tier?.trim() ?? '',
    year: Number(payload.year),
    title: payload.title?.trim() ?? '',
    startDate: payload.startDate ?? null,
    endDate: payload.endDate ?? null,
    city: payload.city?.trim() ?? '',
    country: payload.country?.trim() ?? '',
    submissionDeadline: payload.submissionDeadline ?? null,
    cfpUrl: payload.cfpUrl?.trim() ?? '',
    callForPapers: payload.callForPapers?.trim() ?? ''
  };
};

const validatePayload = (payload: VenueInstancePayload) => {
  if (!payload.title || !payload.city || !payload.country || !Number.isInteger(payload.year)) {
    throw new Error('Venue title, year, city, and country are required.');
  }

  const currentYear = new Date().getFullYear();
  if (payload.year < currentYear) {
    throw new Error('Venue year must be this year or later.');
  }

  if (payload.startDate) {
    const startYear = new Date(payload.startDate).getUTCFullYear();
    if (startYear !== payload.year) {
      throw new Error('Start date must fall within the selected venue year.');
    }
  }

  if (payload.endDate) {
    const endYear = new Date(payload.endDate).getUTCFullYear();
    if (endYear !== payload.year) {
      throw new Error('End date must fall within the selected venue year.');
    }
  }

  if (payload.startDate && payload.endDate && payload.endDate < payload.startDate) {
    throw new Error('End date must be on or after the start date.');
  }

  if (payload.submissionDeadline) {
    const deadlineYear = new Date(payload.submissionDeadline).getUTCFullYear();
    if (deadlineYear > payload.year) {
      throw new Error('Submission deadline cannot fall after the selected venue year.');
    }
  }

  if (payload.startDate && payload.submissionDeadline && payload.submissionDeadline >= payload.startDate) {
    throw new Error('Submission deadline must be before the conference start date.');
  }

  if (payload.existingSeriesId) {
    return;
  }

  if (!payload.newSeriesName || !payload.typicalMonth || !payload.typicalCityPolicy) {
    throw new Error('New series requests need a series name, typical month, and city policy.');
  }

  if (!payload.existingOrgId && (!payload.newOrganizationName || !payload.newOrganizationWebsite)) {
    throw new Error('New series requests need either an existing organization or a new organization name and website.');
  }
};

const normalizeName = (value: string) => value.trim().toLowerCase();

const resolveOrganizationId = async (connection: PoolConnection, payload: VenueInstancePayload) => {
  if (payload.existingOrgId) return payload.existingOrgId;

  const [existingRows] = await connection.query<RowDataPacket[]>(
    `
    SELECT OrgID AS orgId
    FROM ORGANIZATION
    WHERE LOWER(Name) = ? OR Website = ?
    LIMIT 1
    `,
    [normalizeName(payload.newOrganizationName), payload.newOrganizationWebsite]
  );

  if (existingRows[0]?.orgId) return Number(existingRows[0].orgId);

  const [result] = await connection.query<ResultSetHeader>(
    `
    INSERT INTO ORGANIZATION (Name, Website, Society, Publisher, University)
    VALUES (?, ?, ?, ?, ?)
    `,
    [
      payload.newOrganizationName,
      payload.newOrganizationWebsite,
      payload.newOrganizationSociety || null,
      payload.newOrganizationPublisher || null,
      payload.newOrganizationUniversity || null
    ]
  );

  return result.insertId;
};

const resolveSeriesId = async (connection: PoolConnection, payload: VenueInstancePayload) => {
  if (payload.existingSeriesId) return payload.existingSeriesId;

  const orgId = await resolveOrganizationId(connection, payload);

  const [existingRows] = await connection.query<RowDataPacket[]>(
    `
    SELECT SeriesID AS seriesId
    FROM VENUE_SERIES
    WHERE OrgID = ?
      AND (
        LOWER(Name) = ?
        OR (? <> '' AND LOWER(Acronym) = ?)
      )
    LIMIT 1
    `,
    [
      orgId,
      normalizeName(payload.newSeriesName),
      payload.newSeriesAcronym,
      normalizeName(payload.newSeriesAcronym)
    ]
  );

  if (existingRows[0]?.seriesId) return Number(existingRows[0].seriesId);

  const [seriesInsert] = await connection.query<ResultSetHeader>(
    `
    INSERT INTO VENUE_SERIES (OrgID, Name, Acronym, Description, ActiveFlag)
    VALUES (?, ?, ?, ?, TRUE)
    `,
    [
      orgId,
      payload.newSeriesName,
      payload.newSeriesAcronym || null,
      payload.newSeriesDescription || null
    ]
  );

  const seriesId = seriesInsert.insertId;

  await connection.query(
    `
    INSERT INTO CONFERENCE_SERIES (SeriesID, TypicalMonth, TypicalCityPolicy, Tier)
    VALUES (?, ?, ?, ?)
    `,
    [
      seriesId,
      payload.typicalMonth,
      payload.typicalCityPolicy,
      payload.tier || null
    ]
  );

  return seriesId;
};

const createVenueInstance = async (connection: PoolConnection, payload: VenueInstancePayload) => {
  const seriesId = await resolveSeriesId(connection, payload);

  const [conflictRows] = await connection.query<RowDataPacket[]>(
    `
    SELECT 1
    FROM VENUE_INSTANCE
    WHERE SeriesID = ? AND Year = ?
    LIMIT 1
    `,
    [seriesId, payload.year]
  );

  if (conflictRows.length > 0) {
    throw new Error('A venue instance already exists for that series and year.');
  }

  await connection.query(
    `
    INSERT INTO VENUE_INSTANCE (
      SeriesID, Year, Title, StartDate, EndDate, City, Country,
      SubmissionDeadline, CFP_URL, CallForPapers, Reviewing, Published
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, FALSE, FALSE)
    `,
    [
      seriesId,
      payload.year,
      payload.title,
      payload.startDate,
      payload.endDate,
      payload.city,
      payload.country,
      payload.submissionDeadline,
      payload.cfpUrl || null,
      payload.callForPapers || null
    ]
  );
};

const checkSubmissionConflicts = async (payload: VenueInstancePayload) => {
  if (!payload.existingSeriesId && !payload.existingOrgId && payload.newOrganizationName && payload.newOrganizationWebsite) {
    const [organizationRows] = await pool.query<RowDataPacket[]>(
      `
      SELECT 1
      FROM ORGANIZATION
      WHERE LOWER(Name) = ? OR Website = ?
      LIMIT 1
      `,
      [normalizeName(payload.newOrganizationName), payload.newOrganizationWebsite]
    );

    if (organizationRows.length > 0) {
      throw new Error('That organization already exists. Choose the existing organization instead of creating a duplicate.');
    }
  }

  if (!payload.existingSeriesId) {
    const targetOrgId = payload.existingOrgId
      ? payload.existingOrgId
      : null;

    if (targetOrgId && payload.newSeriesName) {
      const [seriesRows] = await pool.query<RowDataPacket[]>(
        `
        SELECT 1
        FROM VENUE_SERIES
        WHERE OrgID = ?
          AND (
            LOWER(Name) = ?
            OR (? <> '' AND LOWER(Acronym) = ?)
          )
        LIMIT 1
        `,
        [
          targetOrgId,
          normalizeName(payload.newSeriesName),
          payload.newSeriesAcronym,
          normalizeName(payload.newSeriesAcronym)
        ]
      );

      if (seriesRows.length > 0) {
        throw new Error('That series already exists for the selected organization. Use the existing series option instead.');
      }
    }

    return;
  }

  const [instanceRows] = await pool.query<RowDataPacket[]>(
    `
    SELECT 1
    FROM VENUE_INSTANCE
    WHERE SeriesID = ? AND Year = ?
    LIMIT 1
    `,
    [payload.existingSeriesId, payload.year]
  );

  if (instanceRows.length > 0) {
    throw new Error('That series already has a venue instance for the selected year.');
  }

  const [requestRows] = await pool.query<RowDataPacket[]>(
    `
    SELECT 1
    FROM REQUEST
    WHERE RequestType = 'venue_instance_submission'
      AND Status = 'pending'
      AND JSON_EXTRACT(PayloadJSON, '$.existingSeriesId') = ?
      AND JSON_EXTRACT(PayloadJSON, '$.year') = ?
    LIMIT 1
    `,
    [payload.existingSeriesId, payload.year]
  );

  if (requestRows.length > 0) {
    throw new Error('There is already a pending request for that series and year.');
  }
};

export const getRequestMeta = asyncHandler(async (_req: Request, res: Response) => {
  try {
    const [organizationRows] = await pool.query(
      `
      SELECT OrgID AS orgId, Name AS name, Website AS website
      FROM ORGANIZATION
      ORDER BY Name ASC
      `
    );

    const [seriesRows] = await pool.query(
      `
      SELECT
        vs.SeriesID AS seriesId,
        vs.OrgID AS orgId,
        o.Name AS organization,
        vs.Name AS name,
        vs.Acronym AS acronym
      FROM VENUE_SERIES vs
      JOIN CONFERENCE_SERIES cs ON cs.SeriesID = vs.SeriesID
      JOIN ORGANIZATION o ON o.OrgID = vs.OrgID
      ORDER BY o.Name ASC, vs.Name ASC
      `
    );

    const [seriesYearRows] = await pool.query<RowDataPacket[]>(
      `
      SELECT SeriesID AS seriesId, Year AS year
      FROM VENUE_INSTANCE
      ORDER BY SeriesID ASC, Year ASC
      `
    );

    const yearsBySeriesMap = new Map<number, number[]>();
    for (const row of seriesYearRows) {
      const seriesId = Number(row.seriesId);
      const year = Number(row.year);
      const years = yearsBySeriesMap.get(seriesId) ?? [];
      years.push(year);
      yearsBySeriesMap.set(seriesId, years);
    }

    res.json({
      organizations: organizationRows as OrganizationSummary[],
      conferenceSeries: seriesRows as ConferenceSeriesSummary[],
      usedYearsBySeries: Array.from(yearsBySeriesMap.entries()).map(([seriesId, years]) => ({
        seriesId,
        years
      })) as SeriesYearSummary[]
    });
  } catch (err) {
    res.status(500).json({
      error: 'query failed',
      details: err instanceof Error ? err.message : String(err)
    });
  }
});

export const createVenueRequest = asyncHandler(async (req: Request, res: Response) => {
  const { submittedByUserId, payload } = req.body as {
    submittedByUserId?: number;
    payload?: unknown;
  };

  try {
    if (!submittedByUserId) {
      throw new Error('Organizer account is required.');
    }

    const parsedPayload = parsePayload(payload);
    validatePayload(parsedPayload);
    await checkSubmissionConflicts(parsedPayload);

    const [result] = await pool.query<ResultSetHeader>(
      `
      INSERT INTO REQUEST (SubmittedByUserID, PayloadJSON, Status, RequestType)
      VALUES (?, ?, 'pending', 'venue_instance_submission')
      `,
      [submittedByUserId, JSON.stringify(parsedPayload)]
    );

    res.status(201).json({ requestId: result.insertId });
  } catch (err) {
    res.status(400).json({
      error: err instanceof Error ? err.message : String(err)
    });
  }
});

export const getAdminRequests = asyncHandler(async (_req: Request, res: Response) => {
  try {
    const [rows] = await pool.query(
      `
      SELECT
        r.RequestID AS requestId,
        r.SubmittedByUserID AS submittedByUserId,
        submitter.DisplayName AS submittedByName,
        r.ReviewedByUserID AS reviewedByUserId,
        reviewer.DisplayName AS reviewedByName,
        r.CreatedAt AS createdAt,
        r.Status AS status,
        r.RequestType AS requestType,
        r.PayloadJSON AS payloadJson
      FROM REQUEST r
      JOIN USER submitter ON submitter.UserID = r.SubmittedByUserID
      LEFT JOIN USER reviewer ON reviewer.UserID = r.ReviewedByUserID
      WHERE r.RequestType = 'venue_instance_submission'
      ORDER BY
        CASE r.Status
          WHEN 'pending' THEN 0
          WHEN 'approved' THEN 1
          ELSE 2
        END,
        r.CreatedAt DESC
      `
    );

    const requests = (rows as RequestRow[]).map((row) => ({
      ...row,
      payload: parsePayload(row.payloadJson)
    }));

    res.json({ requests });
  } catch (err) {
    res.status(500).json({
      error: 'query failed',
      details: err instanceof Error ? err.message : String(err)
    });
  }
});

export const reviewRequest = asyncHandler(async (req: Request, res: Response) => {
  const { reviewedByUserId, status } = req.body as {
    reviewedByUserId?: number;
    status?: Status;
  };

  const requestId = Number(req.params.id);

  if (!reviewedByUserId || !status || !['approved', 'rejected'].includes(status)) {
    res.status(400).json({ error: 'A reviewer and a valid decision are required.' });
    return;
  }

  const connection = await pool.getConnection();

  try {
    await connection.beginTransaction();

    const [rows] = await connection.query<RowDataPacket[]>(
      `
      SELECT RequestID AS requestId, Status AS status, PayloadJSON AS payloadJson
      FROM REQUEST
      WHERE RequestID = ?
      FOR UPDATE
      `,
      [requestId]
    );

    const current = rows[0] as { requestId: number; status: Status; payloadJson: unknown } | undefined;
    if (!current) throw new Error('Request not found.');
    if (current.status !== 'pending') throw new Error('Only pending requests can be reviewed.');

    const payload = parsePayload(current.payloadJson);

    if (status === 'approved') {
      validatePayload(payload);
      await createVenueInstance(connection, payload);
    }

    await connection.query(
      `
      UPDATE REQUEST
      SET Status = ?, ReviewedByUserID = ?
      WHERE RequestID = ?
      `,
      [status, reviewedByUserId, requestId]
    );

    await connection.commit();
    res.json({ ok: true });
  } catch (err) {
    await connection.rollback();
    res.status(400).json({
      error: err instanceof Error ? err.message : String(err)
    });
  } finally {
    connection.release();
  }
});
