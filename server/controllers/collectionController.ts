import asyncHandler from 'express-async-handler';
import pool from '../database.ts';
import type { Request, Response } from 'express';

export const getCollections = asyncHandler(async (req: Request, res: Response) => {
    try {
        const [rows] = await pool.query(
            `
            SELECT 
                c.CollectionID AS collectionId, 
                c.CreatorUserID AS creatorUserId, 
                c.Name AS name, 
                c.Visibility AS visibility, 
                c.CreatedAt AS createdAt, 
                COUNT(*) AS venueInstanceCount
            FROM COLLECTION c
            JOIN COLLECTION_CONTAINS cc ON cc.CollectionID = c.CollectionID
            GROUP BY c.CollectionID, c.CreatorUserID, c.Name, c.Visibility, c.CreatedAt
            `
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});