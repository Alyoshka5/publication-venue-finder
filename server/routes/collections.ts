import express from 'express';
import * as collectionController from '../controllers/collectionController.ts';

const router: express.Router = express.Router();

router.get('/', collectionController.getCollections);

export default router;