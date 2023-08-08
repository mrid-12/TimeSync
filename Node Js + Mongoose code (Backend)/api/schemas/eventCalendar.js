const mongoose = require('mongoose'),
    Schema = mongoose.Schema;

const userEvents = new Schema({
    userId: {type: Schema.Types.ObjectId,ref: 'User'},
    eventTitle: {type: String, required: true},
    timeSlot:{type: Date, required:true} //ask about using maps with events as keys
});


const Events = mongoose.model('Event', userEvents);

module.exports = Events;