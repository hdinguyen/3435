var models  = require('../models');
var express = require('express');
var router = express.Router();

// Update offer
router.post('/:offer_id', function(req, res, next){
    var offer_id = req.params.offer_id;
    var data = req.body.data;
    models.offers.update({
        program_id: data.program_id,
        price: data.price,
        return_program_id: data.return_program_id,
        status: data.status
    },{where: {id: offer_id}}).then(function(offer){
        res.end(JSON.stringify({"status":"success"}));
    }).catch(function (error)
    {
        res.end(JSON.stringify({"status":"error"}));
        console.log(error);
    });
})
module.exports = router;