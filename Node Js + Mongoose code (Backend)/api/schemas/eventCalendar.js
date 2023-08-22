const mongoose = require('mongoose'),
    Schema = mongoose.Schema;

const userEvents = new Schema({
    userId: {type: Schema.Types.ObjectId,ref: 'User'},
    eventTitle: {type: String, required: true},
    startTime:{type: Date, required:true},
    endTime: {type: Date, required:true},
    active: {type:Boolean, required:true} //ask about using maps with events as keys
});

// userEvents.index({eventTitle: 1}, {unique: true, sparse: true});

const Events = mongoose.model('Event', userEvents);

module.exports = Events;