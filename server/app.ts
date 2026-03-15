import express from 'express';
import cors from 'cors';
import type { Request, Response } from 'express';
import pool from './database.ts';

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

const getUpcomingVenues = async (req: Request, res: Response) => {
    try {
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
                o.Name AS organization
            FROM VENUE_INSTANCE vi
            JOIN VENUE_SERIES vs ON vs.SeriesID = vi.SeriesID
            JOIN ORGANIZATION o ON o.OrgID = vs.OrgID
            WHERE vi.Reviewing = FALSE AND vi.Published = FALSE
            ORDER BY (vi.SubmissionDeadline IS NULL) ASC, vi.SubmissionDeadline ASC
            LIMIT 50
            `
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
};

// Route name for the project milestone/demo.
app.get('/api/venues/upcoming', getUpcomingVenues);

app.get('/', (req: Request, res: Response) => {
    res.json('Hello World');
});

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
});
