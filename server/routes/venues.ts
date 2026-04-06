import express from 'express';
import * as venueController from '../controllers/venueController.ts';

const router: express.Router = express.Router();

router.get('/topics', venueController.getTopics);
router.get('/upcoming', venueController.getUpcomingVenues);
router.get('/:seriesId/:year', venueController.getVenueById);
router.get('/:id', venueController.getVenueById);

export default router;
