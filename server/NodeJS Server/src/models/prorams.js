"use strict";


module.exports = function (sequelize, DataTypes) {
	var Offers = sequelize.define("offers", {
        id: DataTypes.INTEGER,
		skill_id: DataTypes.INTEGER,
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
		tableName: 'offers'
	});

	return Offers;
};
