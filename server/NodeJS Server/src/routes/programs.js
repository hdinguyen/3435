var models  = require('../models');
var express = require('express');
var router = express.Router();

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
module.exports = router;