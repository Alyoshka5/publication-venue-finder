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
