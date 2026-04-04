import express from 'express';
import * as collectionController from '../controllers/collectionController.ts';

const router: express.Router = express.Router();

router.get('/user/:userId', collectionController.getCollections);

router.post('/user/:userId', collectionController.createCollection);

router.get('/:id', collectionController.getCollectionInfo);

router.delete('/:id', collectionController.deleteCollection);

router.get('/:id/venues', collectionController.getCollectionVenues);

export default router;