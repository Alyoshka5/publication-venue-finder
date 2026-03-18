import mysql from 'mysql2';
import 'dotenv/config';

const pool = mysql.createPool({
    host: '127.0.0.1',
    user: 'root',
    password: process.env.DB_PASSWORD,
    database: 'publication_venue_finder_db'
}).promise();

export default pool;