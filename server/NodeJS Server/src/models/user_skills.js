"use strict";


module.exports = function (sequelize, DataTypes) {
	var User_skills = sequelize.define("user_skills", {
		user_id: DataTypes.INTEGER,
		details: DataTypes.STRING,
		tag1: DataTypes.STRING,
        tag2: DataTypes.INTEGER,
        tag3: DataTypes.INTEGER,
        tag4: DataTypes.INTEGER,
        tag5: DataTypes.INTEGER,
		level: DataTypes.INTEGER,
		type: DataTypes.INTEGER
	}, {
		timestamps: false
	}, {
		tableName: 'user_skills'
	});

	return User_skills;
};
