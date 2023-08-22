const eventCalendar = require("../schemas/eventCalendar");
const cron = require('node-cron');

const getcurrEvents = function(req,res,next){
    eventCalendar.find({userId: req.params.id}).find({active: true}).sort({endTime: 1})  //limit
    .then(event =>{
            if(event[0]!=null && event[1]!=null){  
                res.status(200);

                res.json(    {
                   "1" : event[0].eventTitle,
                   "1st": event[0].startTime.toString(),
                   "1et": event[0].endTime.toString(),//returns current/ongoing event
                    "2" : event[1].eventTitle.toString(),
                    "2st": event[1].startTime.toString(),
                    '2et': event[1].endTime.toString(),
                    //returns next event
                }
                );
            } else if (event[0]!=null){
                res.status(200);

                res.json(   {
                    "1" : event[0].eventTitle,
                   "1st": event[0].startTime.toString(),
                   "1et": event[0].endTime.toString(),}//returns current/ongoing event
                );
            } else {
                res.status(201);
                res.send("No events created !");
            }
            
    },(err)=>{
        console.log(err);
        res.status(400);
        res.send("An Error occurred")
    });
}

const getAllEventsForUser = function(req, res, next){
    eventCalendar.find({userId: req.params.id}).find({active: true}).sort({endTime: 1}).then((doc)=>{
        res.status(200);
        console.log(doc);
        res.json(
            doc
        );
    }, (err) => {
        console.log(err);
        res.status(400);
        res.send("Unable to fetch user");
    });
}

const createEvent = function(req,res,next){
    var event = new eventCalendar(req.body);
    event.save().then(() => {
        res.status(201);
        res.send("Event created successfully");
    }, err => {
        if (err.code === 11000) {
            res.status(400); 
            res.send("Please use unique names for your events !");
        }
        console.log(err),
        res.status(400);
        res.send("Input failed");
    })
}

const deleteEvent = function(req,res,next){
    eventCalendar.findOneAndDelete({userId: req.body.id, eventTitle: req.body.title, active:true}).then((doc)=>{
        res.status(200);
        res.send("Deleted succesfully!");
    }, (err) => {
        res.status(400);
        res.send("No such event exists!");
    });
}

cron.schedule('* * * * *',()=>{
    var date = new Date();
    var now_utc = new Date(Date.UTC(date.getUTCFullYear(), date.getUTCMonth(),
                date.getUTCDate(), date.getUTCHours(),
                date.getUTCMinutes(), date.getUTCSeconds()));
    console.log(now_utc);
    const filter = {endTime: {$lt:now_utc}};
    eventCalendar.deleteMany(filter).then(console.log('cleared'));
});

//deleting elements during the event loop if the time period has crossed
//cron

module.exports = {
    getcurrEvents, getAllEventsForUser, createEvent,deleteEvent}
