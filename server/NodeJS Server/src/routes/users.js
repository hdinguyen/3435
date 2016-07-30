var models  = require('../models');
var express = require('express');
var router = express.Router();
var FB = require('fb');
var async = require('async');

var fb_credentials = {
	client_id: '322571938081191',
	client_secret: '76f01857cf3e8061980d765fd28eea0c',
	version: 'v2.7'
};
FB.options({appId: fb_credentials.client_id, appSecret: fb_credentials.client_secret, version: fb_credentials.version});


// START USERS
/* GET users listing. */
router.get('/:user_id', function(req, res, next) {
  var user_id = req.params.user_id;
  models.users.findById(user_id).then(function(user){
    res.end(JSON.stringify(user));
  }).catch(function (error)
  {
    res.end(JSON.stringify({"status":"error"}));
    console.log(error);
  });
});

// Update infomation
router.post('/:user_id',function(req, res, next){
  var user_id = req.params.user_id;
  var user_data = req.body.user;
  console.log(user_data);
  // Update user
  models.users.update({
      id: user_data.id,
      secret: user_data.token,
      source: 'FACEBOOK',
      email: user_data.email ? user_data.email: null
    }).then(function (){
      res.end(JSON.stringify({"status":"success"}));
  }).catch(function (error)
  {
    res.end(JSON.stringify({"status":"error"}));
    console.log(error);
  });
  // Return status
  res.end();
});

// Authentication and create/update token for user
router.post('/oauth/facebook', function (req, res){
	var token = req.body.token;
  var email = req.body.email;
  var photo_url = req.body.photo_url;
	var fb = FB.extend();
  fb.setAccessToken(token);
  fb.api('/me', 'get',
    {
      fields: ['id', 'name', 'first_name', 'last_name', 'email', 'location', 'locale', 'age_range', 'gender', 'birthday']
    },
    function (fb_res){
      if (!fb_res || fb_res.error){
        res.end(JSON.stringify({'status':'Error'}));
        console.log(fb_res? fb_res.error: 'error');
        return;
      }

      models.users.findOrCreate({
        where: {
          id: fb_res.id
        }
      }).spread(function(user, created)
      {
          user.fullname = fb_res.fullname? fb_res.fullname: null;
          user.email = email ? email: user.email;
          user.dayofbirth = fb_res.birthday? Date.parse(fb_res.birthday): null;
          user.status = 'active';
          user.access_token = token;
          user.photo_url = photo_url ? photo_url: user.photo_url;
          // Update user
          console.log(user);

          user.save().then(function (){
              res.end(JSON.stringify({"status":"success"}));
          },function (err){
            res.end(JSON.stringify({"status":"error"}));
            console.log(err);
          }).catch(function (error)
          {
            res.end(JSON.stringify({"status":"error"}));
            console.log(error);
          });

          // Return status
          
      });
    });
});
// END UESRS

// START COURSE
// Get list skills of user
router.get('/:user_id/skills', function(req, res, next) {
  var type = req.query.type; // 0: Accquired / 1: Listed / 2: Interest
  var user_id = req.params.user_id;
  var where_clause = {user_id: user_id};
  if (type) {
    where_clause.type = type;
  }
  models.user_skills.findAll({where:where_clause}).then(function(user_skills){
    res.end(JSON.stringify({status: "success", data: user_skills}));
  }).catch(function (error)
  {
    res.end(JSON.stringify({"status":"error"}));
    console.log(error);
  });
});

// Update list skils of user
router.post('/:user_id/skills', function(req, res, next) {
  var user_id = req.params.user_id;
  // 0: Accquired / 1: Listed / 2: Interest
  var skill_type = req.body.skill_type;
  var data = req.body.data;
  async.map(data, function(skill, next){
    models.user_skills.findOrCreate({where: {
      user_id: user_id,
      details: skill.details,
      tag1: skill.tag1,
      tag2: skill.tag2,
      tag3: skill.tag3,
      tag4: skill.tag4,
      tag5: skill.tag5,
      level: skill.level,
      type: skill_type
    }
    }).spread(function (skill, created){
      next(null, created);
    },function (error)
    {
      console.log(error);
      next(error);
    });
  },function(error, results){
    if (error){
      res.end(JSON.stringify({status: 'error'}));
    }
      else {
        res.end(JSON.stringify({status: 'success', data: results}))
      }
    }
  );
});
// END COURSE


// Update list skils of user
// Get list skills of user
router.get('/:user_id/courses', function(req, res, next) {
  var user_id = req.params.user_id;
  var type = req.query.type;
  var status = req.query.status;
  var where_clause = {};
  if (status) {
    where_clause.status = status;
  }
  if (type == 'mentee'){
    models.courses.findAll({
      where: where_clause,
      include: [
        {
          model: models.offers, as: 'offer', where: {mentee: user_id, status: 1}
        },
        {
          model: models.programs, as: 'program',
          attributes: [
            'id', 'title', 'details', 'length', 'location'
          ]
        }
      ]
    }).then(function (courses){
        res.end(JSON.stringify({status: 'success', data: courses.map(parse_learning_course)}));
      }
    );
  } else {
    models.courses.findAll({
      where: where_clause,
      include: [
        {
          model: models.offers, as: 'offer', where: {mentor: user_id, status: 1}
        },
        {
          model: models.programs, as: 'program',
          attributes: [
            'id', 'title', 'details', 'length', 'location'
          ]
        }
      ]
    }).then(function (courses){
      res.end(JSON.stringify({status: 'success', data: courses.map(parse_teaching_course)}));
    });
  }

  function parse_learning_course(course){
    return course;
  }

  function parse_teaching_course(course){
    return course;
  }

});


router.get('/:user_id/programs', function(req, res, next) {
  var user_id = req.params.user_id;
  var type = req.query.type;
  var where_clause = {user_id: user_id};
  if (type) {
    where_clause.type = type;
  }
  models.programs.findAll({
    where: {},
    include: [
      {
        model: models.user_skills, as: 'user_skill', where: where_clause, required: true
      }
    ]
  }).then(function (programs){
      res.end(JSON.stringify({status: 'success', data: programs.map(parse_program)}));
    }
  );

  function parse_program(program){
    var dataValues = program.dataValues;
    ["user_id","details", "tag1","tag2", "tag3", "tag4", "tag5","level", "type"].forEach(function(key){
      dataValues[key] = program.user_skill[key];
    });
    return dataValues;
  }
});


router.get('/:user_id/offers', function(req, res, next) {
  var user_id = req.params.user_id;
  var where_clause = {user_id: user_id};
  models.programs.findAll({
    where: {},
    include: [
      {
        model: models.user_skills, as: 'user_skill', where: where_clause, required: true
      },
      {
        model: models.offers, as: 'offers', require: true
      }
    ]
  }).then(function (programs){
      res.end(JSON.stringify({status: 'success', data: programs.map(parse_program)}));
    }
  );

  function parse_program(program){
    var dataValues = program.dataValues;
    ["user_id","details", "tag1","tag2", "tag3", "tag4", "tag5","level", "type"].forEach(function(key){
      dataValues[key] = program.user_skill[key];
    });
    return dataValues;
  }
});


module.exports = router;
