import express from 'express';
import * as authController from '../controllers/authController.ts';

const router: express.Router = express.Router();

router.post('/register', authController.register);
router.post('/login', authController.login);

export default router;
