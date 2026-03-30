import asyncHandler from 'express-async-handler';
import pool from '../database.ts';
import type { Response } from 'express';

type CountRow = {
    totalUpcomingPostings: number;
};

type OrganizationStatRow = {
    organization: string;
    upcomingPostings: number;
};

export const getUpcomingStats = asyncHandler(async (_req, res: Response) => {
    try {
        const [countRows] = await pool.query(
            `
            SELECT COUNT(*) AS totalUpcomingPostings
            FROM VENUE_INSTANCE
            WHERE Reviewing = FALSE AND Published = FALSE
            `
        );

        const [organizationRows] = await pool.query(
            `
            SELECT
                o.Name AS organization,
                COUNT(*) AS upcomingPostings
            FROM VENUE_INSTANCE vi
            JOIN VENUE_SERIES vs ON vs.SeriesID = vi.SeriesID
            JOIN ORGANIZATION o ON o.OrgID = vs.OrgID
            WHERE vi.Reviewing = FALSE AND vi.Published = FALSE
            GROUP BY o.OrgID, o.Name
            ORDER BY upcomingPostings DESC, organization ASC
            `
        );

        const totalCount = (countRows as CountRow[])[0]?.totalUpcomingPostings ?? 0;

        res.json({
            totalUpcomingPostings: totalCount,
            organizationStats: organizationRows as OrganizationStatRow[]
        });
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});
