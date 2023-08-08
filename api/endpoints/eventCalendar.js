const express = require('express');
const router = express.Router()

const eventController = require('./../controllers/eventCalendar');

router
.get('/get', eventController.getcurrEvents)