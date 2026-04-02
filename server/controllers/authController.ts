import asyncHandler from 'express-async-handler';
import { createHash } from 'node:crypto';
import pool from '../database.ts';
import type { Request, Response } from 'express';
import type { PoolConnection, ResultSetHeader, RowDataPacket } from 'mysql2/promise';

type UserRole = 'researcher' | 'organizer' | 'admin';

type UserRow = RowDataPacket & {
    userId: number;
    email: string;
    displayName: string;
    createdAt: string;
    passwordHash: string;
    isAdmin: number;
    isOrganizer: number;
};

const hashPassword = (password: string) => createHash('sha256').update(password).digest('hex');

const resolveRole = (user: Pick<UserRow, 'isAdmin' | 'isOrganizer'>): UserRole => {
    if (user.isAdmin) return 'admin';
    if (user.isOrganizer) return 'organizer';
    return 'researcher';
};

const loadUserByEmail = async (email: string) => {
    const [rows] = await pool.query<UserRow[]>(
        `
        SELECT
            u.UserID AS userId,
            u.Email AS email,
            u.DisplayName AS displayName,
            u.CreatedAt AS createdAt,
            u.PasswordHash AS passwordHash,
            CASE WHEN a.UserID IS NULL THEN 0 ELSE 1 END AS isAdmin,
            CASE WHEN o.UserID IS NULL THEN 0 ELSE 1 END AS isOrganizer
        FROM USER u
        LEFT JOIN ADMIN a ON a.UserID = u.UserID
        LEFT JOIN ORGANIZER o ON o.UserID = u.UserID
        WHERE u.Email = ?
        LIMIT 1
        `,
        [email]
    );

    return rows[0] ?? null;
};

const sanitizeUser = (user: UserRow) => ({
    userId: user.userId,
    email: user.email,
    displayName: user.displayName,
    createdAt: user.createdAt,
    role: resolveRole(user)
});

const insertRoleRow = async (connection: PoolConnection, userId: number, role: UserRole) => {
    if (role === 'admin') {
        await connection.query(`INSERT INTO ADMIN (UserID) VALUES (?)`, [userId]);
        return;
    }

    if (role === 'organizer') {
        await connection.query(`INSERT INTO ORGANIZER (UserID) VALUES (?)`, [userId]);
        return;
    }

    await connection.query(`INSERT INTO RESEARCHER (UserID) VALUES (?)`, [userId]);
};

export const register = asyncHandler(async (req: Request, res: Response) => {
    const email = typeof req.body.email === 'string' ? req.body.email.trim().toLowerCase() : '';
    const displayName = typeof req.body.displayName === 'string' ? req.body.displayName.trim() : '';
    const password = typeof req.body.password === 'string' ? req.body.password : '';
    const role = req.body.role as UserRole | undefined;

    if (!email || !displayName || !password) {
        res.status(400).json({ error: 'email, displayName, and password are required' });
        return;
    }

    if (password.length < 8) {
        res.status(400).json({ error: 'password must be at least 8 characters' });
        return;
    }

    if (role !== 'researcher' && role !== 'organizer' && role !== 'admin') {
        res.status(400).json({ error: 'role must be researcher, organizer, or admin' });
        return;
    }

    const existingUser = await loadUserByEmail(email);
    if (existingUser) {
        res.status(409).json({ error: 'an account with that email already exists' });
        return;
    }

    const connection = await pool.getConnection();

    try {
        await connection.beginTransaction();

        const [result] = await connection.query<ResultSetHeader>(
            `
            INSERT INTO USER (Email, PasswordHash, DisplayName)
            VALUES (?, ?, ?)
            `,
            [email, hashPassword(password), displayName]
        );

        const nextUserId = Number(result.insertId);
        await insertRoleRow(connection, nextUserId, role);
        await connection.commit();

        const createdUser = await loadUserByEmail(email);
        if (!createdUser) {
            throw new Error('user creation succeeded but lookup failed');
        }

        res.status(201).json({ user: sanitizeUser(createdUser) });
    } catch (err) {
        await connection.rollback();
        res.status(500).json({
            error: 'registration failed',
            details: err instanceof Error ? err.message : String(err)
        });
    } finally {
        connection.release();
    }
});

export const login = asyncHandler(async (req: Request, res: Response) => {
    const email = typeof req.body.email === 'string' ? req.body.email.trim().toLowerCase() : '';
    const password = typeof req.body.password === 'string' ? req.body.password : '';

    if (!email || !password) {
        res.status(400).json({ error: 'email and password are required' });
        return;
    }

    const user = await loadUserByEmail(email);
    if (!user || user.passwordHash !== hashPassword(password)) {
        res.status(401).json({ error: 'invalid email or password' });
        return;
    }

    res.json({ user: sanitizeUser(user) });
});
