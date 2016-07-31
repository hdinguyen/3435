var models  = require('../models');
var express = require('express');
var router = express.Router();
var categories_map = {};
models.categories.findAll({
    attributes : ['id', 'title']
}).then(function (data){
    data.forEach(function(element) {
        categories_map["k" + element.id] = element.title;
    }, this);
});




/* Create program */
router.post('/', function(req, res, next) {
    var data = req.body.data;
    models.programs.create({
        user_skill_id: data.user_skill_id,
        title: data.title,
        details: data.details,
        length: data.length,
        price: data.price,
        is_offline: data.is_offline,
        location: data.location
    }).then(function(program)
    {
        res.end(JSON.stringify({"status":"success"}));
    }).catch(function (error)
    {
        res.end(JSON.stringify({"status":"error"}));
        console.log(error);
    });
});


/* Update program */
router.post('/:program_id/', function(req, res, next) {
  var program_id = req.params.program_id;
  var data = req.body.data;
    models.programs.update({
        user_skill_id: data.user_skill_id,
        title: data.title,
        details: data.details,
        length: data.length,
        price: data.price,
        is_offline: data.is_offline,
        location: data.location
    },
    {
        where: {
            id: program_id
    }}).then(function(program)
    {
        res.end(JSON.stringify({"status":"success"}));
    }).catch(function (error)
    {
        res.end(JSON.stringify({"status":"error"}));
        console.log(error);
    });
});

// Create offer
router.post('/:program_id/offer', function(req, res, next) {
    var program_id = req.params.program_id;
    var data = req.body.data;
    console.log(data);
    models.programs.findById(program_id).then(function(program){
        var skill_id = program.user_skill_id;
        models.user_skills.findById(skill_id).then(function(user_skill){
            user_skill = user_skill.dataValues;
            var user_id = user_skill.user_id;
            var type = user_skill.type;
            console.log(type);
            if(type == '0' || type == '1') // Teach
            {
                console.log("teach");
                models.offers.findOrCreate({where: {program_id: program_id},
                defaults: { 
                    mentor: user_id,
                    program_id: program_id,
                    mentee: data.mentee,
                    price: data.price,
                    return_program_id: data.return_program_id,
                    type: data.type,
                    status: data.status
                }}).spread(function(offer, created){
                    if(created)
                    {
                        res.end(JSON.stringify({"status":"success"}));
                    }else
                    {
                        // Update new value to offers
                        models.offers.update({
                            program_id: data.program_id,
                            price: data.price,
                            return_program_id: data.return_program_id,
                            status: data.status
                        },{where: {id: offer.id}}).then(function(){
                            // Get new value from offers
                            models.offers.findById(offer.id).then(function(new_offer)
                            {
                                if(new_offer.status == "0") // Offering
                                    res.end(JSON.stringify({"status":"success"}));
                                else // Done
                                {
                                    console.log("return:    " + new_offer.return_program_id);
                                    // Check exits return program
                                    if(new_offer.return_program_id > 0)
                                    {
                                        // Create courses for mentor
                                        models.courses.create({
                                            offer_id: new_offer.id,
                                            program_id: new_offer.program_id
                                        }).then(function(){
                                            models.courses.create({
                                                offer_id: new_offer.id,
                                                program_id: new_offer.return_program_id
                                            }).then(function(){
                                                res.end(JSON.stringify({"status":"success"}));
                                            }).catch(function (error)
                                            {
                                                res.end(JSON.stringify({"status":"error"}));
                                                console.log(error);
                                            });
                                        }).catch(function (error)
                                        {
                                            res.end(JSON.stringify({"status":"error"}));
                                            console.log(error);
                                        });
                                    }
                                    else // Get price to teach
                                    {
                                        models.courses.create({
                                            offer_id: new_offer.id,
                                            program_id: new_offer.program_id
                                        }).then(function(){
                                            res.end(JSON.stringify({"status":"success"}));
                                        }).catch(function (error)
                                        {
                                            res.end(JSON.stringify({"status":"error"}));
                                            console.log(error);
                                        });
                                    }
                                }
                            });
                        }).catch(function (error)
                        {
                            res.end(JSON.stringify({"status":"error"}));
                            console.log(error);
                        });
                    }
                }).catch(function (error)
                {
                    res.end(JSON.stringify({"status":"error"}));
                    console.log(error);
                });
            }else // Learn
            {
                console.log("learn");
                models.offers.findOrCreate({where: {program_id: program_id},
                defaults: { 
                    mentor: data.mentor,
                    program_id: program_id,
                    mentee: user_id,
                    price: data.price,
                    return_program_id: data.return_program_id,
                    type: data.type,
                    status: data.status
                }}).spread(function(offer, created){
                    if(created)
                    {
                        res.end(JSON.stringify({"status":"success"}));
                    }else
                    {
                        // Update new value to offers
                        models.offers.update({
                            program_id: data.program_id,
                            price: data.price,
                            return_program_id: data.return_program_id,
                            status: data.status
                        },{where: {id: offer.id}}).then(function(){
                            // Get new value from offers
                            models.offers.findById(offer.id).then(function(new_offer)
                            {
                                if(new_offer.status == "0") // Offering
                                    res.end(JSON.stringify({"status":"success"}));
                                else // Done
                                {
                                    // Check exits return program
                                    if(new_offer.return_program_id > 0)
                                    {
                                        // Create courses for mentor
                                        models.courses.create({
                                            offer_id: new_offer.id,
                                            program_id: new_offer.program_id
                                        }).then(function(){
                                            models.courses.create({
                                                offer_id: new_offer.id,
                                                program_id: new_offer.return_program_id
                                            });
                                        }).then(function(){
                                            res.end(JSON.stringify({"status":"success"}));
                                        }).catch(function (error)
                                        {
                                            res.end(JSON.stringify({"status":"error"}));
                                            console.log(error);
                                        });
                                    }
                                    else // Pay price to learn
                                    {
                                        models.courses.create({
                                            offer_id: new_offer.id,
                                            program_id: new_offer.program_id
                                        }).then(function(){
                                            res.end(JSON.stringify({"status":"success"}));
                                        }).catch(function (error)
                                        {
                                            res.end(JSON.stringify({"status":"error"}));
                                            console.log(error);
                                        });
                                    }
                                }
                            });
                        }).catch(function (error)
                        {
                            res.end(JSON.stringify({"status":"error"}));
                            console.log(error);
                        });
                        
                    }
                }).catch(function (error)
                {
                    res.end(JSON.stringify({"status":"error"}));
                    console.log(error);
                });
            }
        });
    }).catch(function (error)
    {
        res.end(JSON.stringify({"status":"error"}));
        console.log(error);
    });

});


/* Create program */
router.get('/best', function(req, res, next) {
    var user_id = req.query.user_id;
    var type = req.query.type;
    var magic_query = "(select GROUP_CONCAT(id) FROM (select a.user_id as id ,sum(case " +
        "when ifnull(a.tag1,-2) = ifnull(b.tag1,-1) and ifnull(a.tag2,-2) <> ifnull(b.tag2,-1) " +
        "then 1/3 when ifnull(a.tag1,-2) = ifnull(b.tag1,-1) and ifnull(a.tag2,-2) = ifnull(b.tag2,-1) " +
        "and ifnull(a.tag3,-2) <> ifnull(b.tag3,-1) then 2/3 when ifnull(a.tag1,-2) = ifnull(b.tag1,-1) " +
        " and ifnull(a.tag2,-2) = ifnull(b.tag2,-1) and ifnull(a.tag3,-2) = ifnull(b.tag3,-1) then 1 " +
        "else 0 end ) as MatchPoint from user_skills as a join user_skills as b on a.user_id <> b.user_id " +
        "where b.user_id = :qID and ((b.type = 2 and a.type <> 2) or (b.type <> 2 and a.type = 2)) " +
        "group by a.user_id order by MatchPoint Desc ) as best ) ";
    magic_query = magic_query.replace(":qID", ""+user_id);


    console.log(magic_query);
    var where_clause = {};
    if (type) {
        where_clause.type = type;
    }
    models.programs.findAll({
        where: {},
        include: [
            {
                model: models.user_skills, as: 'user_skill', where: where_clause, required: true
            }
        ],
        order: "FIELD('user_id', :magic)".replace(':magic', magic_query)
    }).then(function (programs){
          res.end(JSON.stringify({status: 'success', data: programs.map(parse_program)}));
      }
    );

    function parse_program(program){
        var dataValues = program.dataValues;
        ["user_id","details", "tag1","tag2", "tag3", "tag4", "tag5","level", "type"].forEach(function(key){
            if(key.indexOf('tag') >= 0)
            {
                if(categories_map["k"+program.user_skill[key]])
                    dataValues.user_skill[key] = categories_map["k"+program.user_skill[key]];
            }
        });
        return dataValues;
    }
});


module.exports = router;
