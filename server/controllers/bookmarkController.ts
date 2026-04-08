import type { Request, Response } from 'express';
import pool from '../database.ts';
import asyncHandler from 'express-async-handler';

export const addBookmark = asyncHandler(async (req: Request, res: Response) => {
    const { userId, seriesId, year } = req.body;

    if (!userId || !seriesId || !year) {
        res.status(400).json({ error: 'Missing fields' });
        return;
    }

    await pool.query(
      `
      INSERT IGNORE INTO BOOKMARKS (UserID, SeriesID, Year, BookmarkedTimestamp)
      VALUES (?, ?, ?, NOW())
      `,
        [userId, seriesId, year]
    );

    res.json({ success: true });
});

export const removeBookmark = asyncHandler(async (req: Request, res: Response) => {
    const { userId, seriesId, year } = req.body;

    await pool.query(
        `DELETE FROM BOOKMARKS WHERE UserID = ? AND SeriesID = ? AND Year = ?`,
        [userId, seriesId, year]
    );

    res.json({ success: true });
});
