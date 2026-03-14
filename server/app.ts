import express from 'express';
import cors from 'cors';
import type { Request, Response } from 'express';

const app = express();
const port = 3000;

app.use(cors());

app.get('/', (req: Request, res: Response) => {
    res.json('Hello World');
});

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
});