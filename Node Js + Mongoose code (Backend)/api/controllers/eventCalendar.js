const eventCalendar = require("../schemas/eventCalendar");

const getcurrEvents = function(req,res,next){
    eventCalendar.findByID(req.query.userId).sort({timeSlot: 1})  
    .then(event =>{
        res.status(200);
        res.json(
            event[0].eventTitle, //returns current/ongoing event
            event[1].eventTitle  //returns next event
        ); 
    },(err)=>{
        console.log(err);
        res.status(400);
        res.send("No events created !")
    });
}

const getAllEventsForUser = function(req, res, next){
    eventCalendar.findByID(req.query.userId).then((doc)=>{
        res.status(200);
        res.json(doc);
    }, (err) => {
        res.status(400);
        res.send("Unable to fectch user");
    });
}

const createEvent = function(req,res,next){
    var event = new eventCalendar(req.body);
    user.save().then(() => {
        res.status(201);
        res.send("Event created successfully");
    }, err => {
        res.status(400);
        res.send("Unable to create now");
    })
}

//deleting elements during the event loop if the time period has crossed
//cron

module.exports = {
    getcurrEvents, getAllEventsForUser, createEvent}
