"use strict";


module.exports = function (sequelize, DataTypes) {
	var Users = sequelize.define("courses", {
        id: DataTypes.INTEGER,
		offer_id: DataTypes.INTEGER,
		mentor_id: DataTypes.INTEGER,
		mentee_id: DataTypes.INTEGER,
		created_at: DataTypes.DATE,
		updated_at: DataTypes.DATE
	}, {
		timestamps: false
	}, {
		tableName: 'courses'
	});

	return Users;
};
