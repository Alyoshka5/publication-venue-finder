import express from 'express';
import * as requestController from '../controllers/requestController.ts';

const router: express.Router = express.Router();

router.get('/meta', requestController.getRequestMeta);
router.post('/', requestController.createVenueRequest);
router.get('/admin', requestController.getAdminRequests);
router.patch('/admin/:id', requestController.reviewRequest);

export default router;
