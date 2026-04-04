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
                c.CreatedAt AS createdAt, 
                COUNT(cc.CollectionID) AS venueInstanceCount
            FROM COLLECTION c
            LEFT JOIN COLLECTION_CONTAINS cc ON cc.CollectionID = c.CollectionID
            WHERE creatorUserId = ?
            GROUP BY c.CollectionID, c.CreatorUserID, c.Name, c.CreatedAt
            ORDER BY createdAt DESC
            `,
            [req.params.userId]
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const createCollection = asyncHandler(async (req: Request, res: Response) => {
    const { name } = req.body;

    try {
        const [result] = await pool.query(
            `
            INSERT 
            INTO COLLECTION (CreatorUserID, Name)
            VALUES (?, ?)
            `,
            [req.params.userId, name]
        );

        res.json({ collectionId: (result as any).insertId });
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const getCollectionInfo = asyncHandler(async (req: Request, res: Response) => {
    try {
        const [rows] = await pool.query(
            `
            SELECT 
                c.CollectionID AS collectionId, 
                c.CreatorUserID AS creatorUserId, 
                c.Name AS name, 
                c.CreatedAt AS createdAt,
                u.DisplayName as creatorName
            FROM COLLECTION c
            JOIN User u ON c.CreatorUserID = u.UserID
            WHERE c.CollectionID = ?
            `,
            [req.params.id]
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const getCollectionVenues = asyncHandler(async (req: Request, res: Response) => {
    try {
        const [rows] = await pool.query(
            `
            SELECT 
                vs.SeriesID AS seriesId,
                vs.Acronym AS acronym,
                vi.Year AS year,
                vi.Title AS title,
                vi.City AS city,
                vi.Country AS country,
                vi.SubmissionDeadline AS submissionDeadline,
                o.Name AS organization
            FROM VENUE_INSTANCE vi
            JOIN VENUE_SERIES vs ON vs.SeriesID = vi.SeriesID
            JOIN ORGANIZATION o ON o.OrgID = vs.OrgID
            JOIN COLLECTION_CONTAINS cc ON cc.SeriesID = vi.SeriesID AND cc.Year = vi.Year
            WHERE cc.CollectionID = ?
            `,
            [req.params.id]
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const updateCollection = asyncHandler(async (req: Request, res: Response) => {
    const { name } = req.body;

    try {
        const [result] = await pool.query(
            `
            UPDATE 
            COLLECTION
            SET Name = ?
            WHERE CollectionID = ?
            `,
            [name, req.params.id]
        );

        res.json(result);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});

export const deleteCollection = asyncHandler(async (req: Request, res: Response) => {
    try {
         await pool.query(
            `DELETE
            FROM COLLECTION_CONTAINS
            WHERE CollectionID = ?`,
            [req.params.id]
        );
        const [result] = await pool.query(
            `DELETE
            FROM COLLECTION
            WHERE CollectionID = ?`,
            [req.params.id]
        );
        res.json(result);
    } catch (err) {
        res.status(500).json({
            error: 'query failed',
            details: err instanceof Error ? err.message : String(err)
        });
    }
});