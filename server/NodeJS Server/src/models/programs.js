"use strict";


module.exports = function (sequelize, DataTypes) {
	var programs = sequelize.define("programs", {
		user_skill_id: DataTypes.INTEGER,
		title: DataTypes.STRING,
		details: DataTypes.STRING,
		length: DataTypes.INTEGER,
		price: DataTypes.DOUBLE,
		is_offline: DataTypes.BOOLEAN,
		location: DataTypes.STRING,
		created_at: DataTypes.DATE,
		updated_at: DataTypes.DATE
	}, {
		timestamps: false
	}, {
		tableName: 'programs'
	});

	return programs;
};
