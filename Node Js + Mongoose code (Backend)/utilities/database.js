const mongoose = require('mongoose')
const dataBaseConnectionString = 'mongodb+srv://mridul:12345@cluster0.36cxzys.mongodb.net/';

const connectToMongoDb = async () => {
    await mongoose
        .connect(dataBaseConnectionString, {})
        .then(() => {
            console.log('DB Connected')
        })
}

module.exports = connectToMongoDb;