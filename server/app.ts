import express from 'express';
import cors from 'cors';
import venueRouter from './routes/venues.ts';
import collectionRouter from './routes/collections.ts';
import adminRouter from './routes/admin.ts';
import authRouter from './routes/auth.ts';
import requestRouter from './routes/requests.ts';
import recommenderRouter from './routes/recommendations.ts';

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());
app.use('/api/venues', venueRouter);
app.use('/api/collections', collectionRouter);
app.use('/api/admin', adminRouter);
app.use('/api/auth', authRouter);
app.use('/api/requests', requestRouter);
app.use('/api/recommendations', recommenderRouter);

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
});
