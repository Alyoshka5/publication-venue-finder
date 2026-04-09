import express from 'express';
import { addBookmark, removeBookmark } from '../controllers/bookmarkController.ts';
import pool from '../database.ts';

const router = express.Router();

router.post('/', addBookmark);

router.get('/:userId/:seriesId/:year', async (req, res) => {
    const { userId, seriesId, year } = req.params;

    const [rows] = await pool.query(
        `SELECT * FROM BOOKMARKS WHERE UserID=? AND SeriesID=? AND Year=?`,
        [userId, seriesId, year]
    );

    res.json({ bookmarked: Array.isArray(rows) && rows.length > 0 });
});

router.delete('/', removeBookmark);

export default router;
