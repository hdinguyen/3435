var models  = require('../models');
var express = require('express');
var router = express.Router();
var FB = require('fb');
var default_fb_redirect_uri = constants.config["facebook_redirect_uri"][constants.env];

var fb_credentials = {
	client_id: '322571938081191',
	client_secret: '76f01857cf3e8061980d765fd28eea0c',
	version: 'v2.7'
};
FB.options({appId: fb_credentials.client_id, appSecret: fb_credentials.client_secret, version: fb_credentials.version});



/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

// Get skills of user
router.get('/skill/:user_id',function(req, res, next){
  var user_id = req.params.user_id;
});

// Get subscribe of user
router.get('/subscribe/:user_id',function(req, res, next){
  var user_id = req.params.user_id;
});

// Update infomation
router.post('/update/:user_id',function(req, res, next){
  var user_id = req.params.user_id;
  var user_data = req.body.user;
  // Update user

  // Return status
  res.end();
});

// Authentication and create/update token for user
router.post('/oauth/facebook', function (req, res){
	var token = req.body.token;
	var fb = FB.extend();
  fb.setAccessToken(body.access_token);
  fb.api('/me', 'get',
    {
      fields: ['id', 'name', 'first_name', 'last_name', 'email', 'location', 'locale', 'age_range', 'gender', 'birthday']
    },
    function (fb_res){
      if (!fb_res || fb_res.error){
        res.end(JSON.stringify({'status':'Error'}));
        return;
      }

      models.users.findOrCreate({
        where: {
          id: fb_res.id
        }
      }).spread(function(user, created)
      {
          user.firstname = fb_res.first_name? fb_res.first_name: null,
          user.email = fb_res.email ? fb_res.email: null,
          user.lastname = fb_res.last_name ? fb_res.last_name : null,
          user.gender = fb_res.gender? fb_res.gender: null,
          user.day_of_birth = fb_res.birthday? Date.parse(fb_res.birthday): null,
          user.status = 'active',
          user.access_token = token
          // Update user


          // Return status
          res.end();
      });
    });
});



module.exports = router;
