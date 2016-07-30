"use strict";

var Sequelize = require("sequelize");
var env       = process.env.NODE_ENV || "development";
var config    = require(__dirname + '/../config/config.json').database[env];
var sequelize = new Sequelize(config.database, config.username, config.password, config);
var db        = {};
var fs        = require("fs");
var path      = require("path");


fs
  .readdirSync(__dirname)
  .filter(function(file) {
    return (file.indexOf(".") !== 0) && (file !== "index.js");
  })
  .forEach(function(file) {
    var model = sequelize.import(path.join(__dirname, file));
    db[model.name] = model;
  });

Object.keys(db).forEach(function(modelName) {
  if ("associate" in db[modelName]) {
    db[modelName].associate(db);
  }
});

db.users.hasMany(db.user_skills, {as: 'skills', foreignKey: 'user_id'});
db.user_skills.belongsTo(db.users, {as: 'user', foreignKey: 'user_id'});
db.programs.hasMany(db.offers, {as: 'offers', foreignKey: 'program_id'});
db.programs.hasMany(db.offers, {as: 'return_offers', foreignKey: 'return_program_id'});
db.offers.belongsTo(db.programs, {as: 'program', foreignKey: 'program_id'});
db.offers.belongsTo(db.programs, {as: 'return_program', foreignKey: 'return_program_id'});
db.user_skills.hasMany(db.programs, {as: 'programs', foreignKey: 'user_skill_id'});
db.programs.belongsTo(db.user_skills, {as: 'user_skill', foreignKey: 'user_skill_id'});
db.courses.belongsTo(db.offers, {as: 'offer', foreignKey: 'offer_id'});
db.offers.hasMany(db.courses, {as: 'courses', foreignKey: 'offer_id'});
db.courses.belongsTo(db.programs, {as: 'program', foreignKey: 'program_id'});
db.programs.hasMany(db.courses, {as: 'courses', foreignKey:'program_id'});


db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
