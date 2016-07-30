"use strict";


module.exports = function (sequelize, DataTypes) {
	var Offers = sequelize.define("offers", {
        id: DataTypes.INTEGER,
		mentor: DataTypes.INTEGER,
		mentee: DataTypes.INTEGER,
		progam_id: DataTypes.INTEGER,
        price: DataTypes.DOUBLE,
        return_progam_id: DataTypes.INTEGER,
		type: DataTypes.INTEGER,
        status: DataTypes.INTEGER,
		created_at: DataTypes.DATE,
		updated_at: DataTypes.DATE
	}, {
		timestamps: false
	}, {
		tableName: 'offers'
	});

	return Offers;
};
