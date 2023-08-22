const User = require('./../schemas/user')
const jwt = require('jsonwebtoken')
const { jsonwebtoken } = require('../../constants/constants');

const login = function (req, res) {
    const name = req.body.name;
    const password = req.body.password;

    User
        .findOne({ name:name, isActive: true })
        .then((user) => {
            if (user == null) {
                res.status(400).send("User not registered")
            } else {
                var foundUser = new User(user);
                var passwordMatched = foundUser.comparePassword(password);
                if (!passwordMatched) {
                    res.status(400).send("Wrong password !")
                } else {
                    let payload = {};
                    payload['id'] = foundUser._id;
                    payload['role'] = 'admin';
                    const token = jwt.sign(payload, jsonwebtoken.key, {
                        expiresIn: 86400
                    })
                    res.status(200).json(payload)
                    // res.status(200).json({ token: token })
                }
            }
        });
}

module.exports = {
    login
}