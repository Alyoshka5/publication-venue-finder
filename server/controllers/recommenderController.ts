// Added by Zoe on 2026-04-03 for recommender algorithm addition

import asyncHandler from 'express-async-handler';
import type { Request, Response } from 'express';

export const getRecommendations = asyncHandler(async (req: Request, res: Response) => {
    const userId = req.query.userId;

    if (!userId) {
        res.status(400).json({ error: 'userId is required' });
        return;
    }
    
    try {
        const response = await fetch(
            `http://127.0.0.1:5000/recommendations?userId=${userId}`
        );
        if (!response.ok) throw new Error(`Flask error: ${response.status}`);
        const data = await response.json();
        res.json(data);
    } catch (err) {
        res.status(500).json({
            error: 'Recommender service failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});