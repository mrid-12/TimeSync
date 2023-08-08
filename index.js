
const express = require('express')

const connectToMongoDb = require('./utilities/database');
const { default: mongoose } = require('mongoose');

const PORT = 8080;
const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}))

connectToMongoDb();

const authRouter = require('./api/endpoints/auth');
const userRouter = require('./api/endpoints/user');
const eventRouter = require('./api/endpoints/eventCalendar');

app.use('/auth', authRouter);
app.use('/user', userRouter);
app.use('/event', eventRouter);

app.get('/', (req, res) => {
    res.send('Server running successfully....')
})

mongoose.connection.once('open', () => {
    app.listen(PORT, () => {
        console.log('Server is running on the port 8080')
    });
})