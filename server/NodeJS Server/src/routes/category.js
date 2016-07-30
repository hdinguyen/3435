var models  = require('../models');
var express = require('express');
var router = express.Router();


router.get('/interest', function(req, res, next) {
  models.categories.findAll()
  .then(function(_categories){
    var list_parent = [];
    _categories.forEach(function(element) {
       if(element.parent_id == 0)
        {
            var e =  element.dataValues;
            e.list_child = [];
            _categories.forEach(function(child){
                if(e.id == child.parent_id)
                    e.list_child.push(child);
            });
            list_parent.push(e);
        }
    }, this);
    //setTimeout(function(){
        res.end(JSON.stringify(list_parent));
    //} , 3000);
    
  }).catch(function (error){
    res.end(JSON.stringify({"status":"error"}));
    console.log(error);
  });
});
module.exports = router;

