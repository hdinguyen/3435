var models  = require('../models');
var express = require('express');
var router = express.Router();


router.get('/interest', function(req, res, next) {
  models.categories.findAll().then(function(_categories){
    var list_parent = [];
    _categories.forEach(function(element) {
       if(element.parent_id == 0)
        {
            element.list_child = [];
            //list_parrent.push()
            _categories.forEach(function(child){
                if(element.id == child.parent_id)
                    element.list_child.push(child);
            });
            list_parrent.push(element);
        }
    }, this);
    res.end(JSON.stringify(list_parent));
  }).catch(function (error){
    res.end(JSON.stringify({"status":"error"}));
    console.log(error);
  });
});
