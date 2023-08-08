// const jwt = require("jsonwebtoken");
// const { jsonwebtoken } = require("../constants/constants");

// function verifyToken(req, res, next) {
//     const token = req.headers['authorization'];
//     if(token) {
//         // verify token
//         jwt.verify(token, jsonwebtoken.key, function(err, decoded) {
//             if(err) {
//                 res.status(400).send('Token error`')
//             } else {
//                 req.userid = decoded.id;
//                 next()
//             }
//         })
//     } else {
//         res.status(400)
//         res.send('Token not passed')
//     }
// }

// module.exports = {
//     verifyToken
// }