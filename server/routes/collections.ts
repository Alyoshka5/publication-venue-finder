import express from 'express';
import * as collectionController from '../controllers/collectionController.ts';
import { addToCollection } from '../controllers/collectionController.ts';
import pool from '../database.ts';

const router: express.Router = express.Router();

// Add to collection
router.post('/', addToCollection);

// Check if collected
router.get('/:userId/:seriesId/:year', async (req, res) => {
    const { userId, seriesId, year } = req.params;

    const [rows] = await pool.query(
        `
        SELECT 1
        FROM COLLECTION c
        JOIN COLLECTION_CONTAINS cc ON cc.CollectionID = c.CollectionID
        WHERE c.CreatorUserID = ? AND cc.SeriesID = ? AND cc.Year = ?
        LIMIT 1
        `,
        [userId, seriesId, year]
    );

    res.json({ collected: Array.isArray(rows) && rows.length > 0 });
});

router.get('/user/:userId', collectionController.getCollections);

router.post('/user/:userId', collectionController.createCollection);

router.get('/:id', collectionController.getCollectionInfo);

router.put('/:id', collectionController.updateCollection);

router.delete('/:id', collectionController.deleteCollection);

router.get('/:id/venues', collectionController.getCollectionVenues);

router.delete('/:id/venues', collectionController.removeVenueFromCollection);

export default router;
