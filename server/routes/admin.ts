import express from 'express';
import * as adminController from '../controllers/adminController.ts';

const router: express.Router = express.Router();

router.get('/upcoming-stats', adminController.getUpcomingStats);

export default router;
