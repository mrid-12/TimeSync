const eventCalendar = require("../schemas/eventCalendar");

const getcurrEvents = function(req,res,next){
    userEvents.find().sort({timeSlot: 1});
}.then(event =>{
    event[0].eventTitle; //returns current/ongoing event
    event[1].eventTitle; //returns next event
});

module.exports = {
    getcurrEvents
}
