var models  = require('../models');
var express = require('express');
var router = express.Router();
var FB = require('fb');

var fb_credentials = {
	client_id: '322571938081191',
	client_secret: '76f01857cf3e8061980d765fd28eea0c',
	version: 'v2.7'
};
FB.options({appId: fb_credentials.client_id, appSecret: fb_credentials.client_secret, version: fb_credentials.version});



/* GET users listing. */
router.get('/:user_id', function(req, res, next) {
  var user_id = req.params.user_id;
  models.users.findById(user_id).then(function(user){
    res.end(JSON.stringify(user));
  }).catch(function (error)
  {
    console.log(error);
  });
});

// Update infomation
router.post('/update/:user_id',function(req, res, next){
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
      res.end(JSON.stringify({"status":"OK"}));
  }).catch(function (error)
  {
    console.log(error);
  });
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
          user.fullname = fb_res.fullname? fb_res.fullname: null,
          user.email = fb_res.email ? fb_res.email: null,
          user.dayofbirth = fb_res.birthday? Date.parse(fb_res.birthday): null,
          user.status = 'active',
          user.access_token = token
          // Update user
          console.log(user);

          models.users.update({
              id: fb_res.id,
              secret: token,
              source: 'FACEBOOK',
              email: fb_user.email ? fb_user.email: null
            }).then(function (){
              res.end(JSON.stringify({"status":"OK"}));
          }).catch(function (error)
          {
            console.log(error);
          });

          // Return status
          
      });
    });
});



module.exports = router;
