const express = require('express');
const router = express.Router()

const eventController = require('./../controllers/eventCalendar');

router
    .get('/eget/:id', eventController.getcurrEvents)
    .get('/egetall/:id', eventController.getAllEventsForUser)
    .post('/ecreate', eventController.createEvent)
    .delete('/edelete',eventController.deleteEvent);

module.exports = router;