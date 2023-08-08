const mongoose = require('mongoose'),
    Schema = mongoose.Schema;

const userEvents = new Schema({
    eventTitle: {type: String, required: true},
    timeSlot:{type: Date, required:true} //ask about using maps with events as keys
});

const eventSchema = new Schema({
    userId: {type: Schema.Types.ObjectId,ref: 'User'},
    events: [userEvents]
});

    

const Events = mongoose.model('Event', eventSchema);

module.exports = Events;