var models  = require('../models');
var express = require('express');
var router = express.Router();


// Get courses list
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

// Get list courses of user
router.get('/:user_id', function(req, res, next) {
  var type = req.body.type; // Learn / Teach
  res.end();
});

// Update list courses of user
router.post('/update/:user_id', function(req, res, next) {
  var type = req.body.type; // Learn / Teach
});

// Get detail of course
router.get('/:course_id', function(req, res, next) {
  var course_id = req.body.course_id; // Learn / Teach
  res.end();
});









