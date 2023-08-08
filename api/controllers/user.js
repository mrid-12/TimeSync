const User = require("../schemas/user");

const getUsers = function (req, res, next) {
    User.find().then((docs) => {
        res.status(200);
        res.json(docs);
    }, (err) => {
        console.log(err);
        res.status(400);
        res.send("Unable to fectch users");
    });
}

const getUserById = function (req, res, next) {
    User.findById(req.query.userId).then((doc) => {
        //    User.find({_id: req.query.userId}).then((doc) => {
        res.status(200);
        res.json(doc);
    }, (err) => {
        res.status(400);
        res.send("Unable to fectch user");
    });
}

const createUser = function (req, res, next) {
    var user = new User(req.body);
    user.save().then(() => {
        res.status(201);
        res.send("User created successfully");
    }, err => {
        if (err.code === 11000) {
            res.status(400);
            res.send("Duplicate Entry");
        }
        res.status(400);
        res.send("Unable to create now");
    })
}

module.exports = {
    getUsers, getUserById, createUser
}