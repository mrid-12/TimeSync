const express = require('express');
const router = express.Router()

const userController = require('./../controllers/user');
// const { verifyToken } = require('../../utilities/middleware');

router
    .get('/get', userController.getUsers)    
    .get('/getId/:name', userController.getIdByUser);
    // .get('/get', verifyToken, userController.getUsers)

router.post('/createUser', userController.createUser);

// I forgot export this export. Thats why it was not working. 
module.exports = router;
