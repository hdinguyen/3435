"use strict";


module.exports = function (sequelize, DataTypes) {
	var User_skills = sequelize.define("user_skills", {
		user_id: DataTypes.STRING,
		details: DataTypes.STRING,
		tag1: DataTypes.STRING,
        tag2: DataTypes.STRING,
        tag3: DataTypes.STRING,
        tag4: DataTypes.STRING,
        tag5: DataTypes.STRING,
		level: DataTypes.STRING,
		type: DataTypes.DATE
	}, {
		timestamps: false
	}, {
		tableName: 'user_skills'
	});

	return User_skills;
};
