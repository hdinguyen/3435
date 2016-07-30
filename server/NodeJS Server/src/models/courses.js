"use strict";


module.exports = function (sequelize, DataTypes) {
	var Courses = sequelize.define("courses", {
		offer_id: DataTypes.INTEGER,
		program_id: DataTypes.INTEGER,
		status: DataTypes.INTEGER,
		created_at: DataTypes.DATE,
		updated_at: DataTypes.DATE
	}, {
		timestamps: false
	}, {
		tableName: 'courses'
	});

	return Courses;
};
