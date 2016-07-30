var models  = require('../models');
var express = require('express');
var router = express.Router();


// Get list courses of user
router.get('/:user_id', function(req, res, next) {
  var type = req.body.type; // 0: My skills / 1: Learned skills / 2: Interest skills
  var user_id = req.params.user_id;
  models.user_skills.find({where:{user_id: user_id, type: type}}).then(function(user){
    res.end(JSON.stringify(user));
  }).catch(function (error)
  {
    console.log(error);
  });
});

// Update list courses of user
router.post('/update/:user_id', function(req, res, next) {
  var user_id = req.params.user_id;
  var type = req.body.type; // 0: My skills / 1: Learned skills / 2: Interest skills
  models.user_skills.update({
        id: user_data.id,
        secret: user_data.token,
        source: 'FACEBOOK',
        email: user_data.email ? user_data.email: null
      }).then(function (){
        res.end(JSON.stringify({"status":"OK"}));
    }).catch(function (error)
    {
      console.log(error);
    });
});

// Get detail of course
router.get('/:course_id', function(req, res, next) {
  var course_id = req.body.course_id; // 0: My skills / 1: Learned skills / 2: Interest skills
  res.end();
});









