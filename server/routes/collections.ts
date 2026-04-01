import express from 'express';
import * as collectionController from '../controllers/collectionController.ts';

const router: express.Router = express.Router();

router.get('/', collectionController.getCollections);

router.get('/:id', collectionController.getCollectionInfo);

router.get('/:id/venues', collectionController.getCollectionVenues);

export default router;