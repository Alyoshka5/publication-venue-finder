// Added for the recommender algorithm by Zoe on 2026-04-03
import express from 'express';
import * as recommenderController from '../controllers/recommenderController.ts';

const router: express.Router = express.Router();

router.get('/', recommenderController.getRecommendations);

export default router;