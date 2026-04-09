import asyncHandler from 'express-async-handler';
import pool from '../database.ts';
import type { Request, Response } from 'express';

const TOPIC_SUBQUERY = `
    SELECT DISTINCT TopicID, Name
    FROM (
        SELECT t.TopicID, t.Name
        FROM TOPIC t
        JOIN SERIES_TAGGED_WITH stw ON stw.TopicID = t.TopicID
        UNION
        SELECT t.TopicID, t.Name
        FROM TOPIC t
        JOIN INSTANCE_TAGGED_WITH itw ON itw.TopicID = t.TopicID
    ) topics
`;

export const getUpcomingVenues = asyncHandler(async (req: Request, res: Response) => {
    try {
        const topicId =
            typeof req.query.topicId === 'string' && req.query.topicId.trim() !== ''
                ? Number(req.query.topicId)
                : null;

        if (topicId !== null && !Number.isInteger(topicId)) {
            res.status(400).json({ error: 'topicId must be an integer' });
            return;
        }

        const [rows] = await pool.query(
            `
            SELECT
                vs.SeriesID AS seriesId,
                vs.Acronym AS acronym,
                vi.Year AS year,
                vi.Title AS title,
                vi.City AS city,
                vi.Country AS country,
                vi.SubmissionDeadline AS submissionDeadline,
                o.Name AS organization,
                COALESCE(
                    (
                        SELECT GROUP_CONCAT(DISTINCT t.Name ORDER BY t.Name SEPARATOR ', ')
                        FROM INSTANCE_TAGGED_WITH itw
                        JOIN TOPIC t ON t.TopicID = itw.TopicID
                        WHERE itw.SeriesID = vi.SeriesID AND itw.Year = vi.Year
                    ),
                    (
                        SELECT GROUP_CONCAT(DISTINCT t.Name ORDER BY t.Name SEPARATOR ', ')
                        FROM SERIES_TAGGED_WITH stw
                        JOIN TOPIC t ON t.TopicID = stw.TopicID
                        WHERE stw.SeriesID = vi.SeriesID
                    )
                ) AS topics
            FROM VENUE_INSTANCE vi
            JOIN VENUE_SERIES vs ON vs.SeriesID = vi.SeriesID
            JOIN ORGANIZATION o ON o.OrgID = vs.OrgID
            WHERE vi.Reviewing = FALSE AND vi.Published = FALSE
              AND (
                    ? IS NULL
                    OR EXISTS (
                        SELECT 1
                        FROM INSTANCE_TAGGED_WITH itwFilter
                        WHERE itwFilter.SeriesID = vi.SeriesID
                          AND itwFilter.Year = vi.Year
                          AND itwFilter.TopicID = ?
                    )
                    OR EXISTS (
                        SELECT 1
                        FROM SERIES_TAGGED_WITH stwFilter
                        WHERE stwFilter.SeriesID = vi.SeriesID
                          AND stwFilter.TopicID = ?
                    )
                )
            ORDER BY (vi.SubmissionDeadline IS NULL) ASC, vi.SubmissionDeadline ASC
            LIMIT 50
            `,
            [topicId, topicId, topicId]
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const getTopics = asyncHandler(async (_req: Request, res: Response) => {
    try {
        const [rows] = await pool.query(
            `
            SELECT TopicID AS topicId, Name AS name
            FROM (${TOPIC_SUBQUERY}) usedTopics
            ORDER BY Name ASC
            `
        );

        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const getSeries = asyncHandler(async (_req: Request, res: Response) => {
    try {
        const [rows] = await pool.query(
            `
            SELECT SeriesID AS seriesId, Acronym AS acronym
            FROM VENUE_SERIES
            ORDER BY acronym ASC
            `
        );

        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const getVenueById = asyncHandler(async (req: Request, res: Response) => {
    const seriesId = Number(req.params.seriesId ?? req.params.id);
    const year =
        typeof req.params.year === 'string' && req.params.year.trim() !== ''
            ? Number(req.params.year)
            : null;

    if (!Number.isInteger(seriesId) || (year !== null && !Number.isInteger(year))) {
        res.status(400).json({ error: 'Invalid ID' });
        return;
    }

    const [rows]: any = await pool.query(
        `
        SELECT
            vs.SeriesID AS seriesId,
            vs.Name AS seriesName,
            vs.Acronym AS acronym,
            vs.Description AS description,

            vi.Year AS year,
            vi.Title AS title,
            vi.City AS city,
            vi.Country AS country,
            vi.StartDate AS startDate,
            vi.EndDate AS endDate,
            vi.SubmissionDeadline AS submissionDeadline,
            vi.CFP_URL AS cfpUrl,
            vi.CallForPapers AS callForPapers,

            o.Name AS organization,
            o.Website AS website,
            o.Society AS society,
            o.Publisher AS publisher,
            o.University AS university,

            cs.TypicalMonth AS typicalMonth,
            cs.Tier AS tier

        FROM VENUE_SERIES vs
        JOIN VENUE_INSTANCE vi ON vs.SeriesID = vi.SeriesID
        JOIN ORGANIZATION o ON vs.OrgID = o.OrgID
        LEFT JOIN CONFERENCE_SERIES cs ON cs.SeriesID = vs.SeriesID

        WHERE vs.SeriesID = ?
          AND (? IS NULL OR vi.Year = ?)
        ORDER BY vi.Year DESC
        LIMIT 1
        `,
        [seriesId, year, year]
    );

    res.json(rows[0] || null);
});
