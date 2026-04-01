import express from 'express';
import cors from 'cors';
import venueRouter from './routes/venues.ts';
import collectionRouter from './routes/collections.ts';
import adminRouter from './routes/admin.ts';

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());
app.use('/api/venues', venueRouter);
app.use('/api/collections', collectionRouter);
app.use('/api/admin', adminRouter);

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
});
