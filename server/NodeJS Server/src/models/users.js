"use strict";


module.exports = function (sequelize, DataTypes) {
	var Users = sequelize.define("users", {
		id_card: DataTypes.STRING,
		fullname: DataTypes.STRING,
		username: DataTypes.STRING,
		credit: DataTypes.STRING,
		dayofbirth: DataTypes.DATE,
        token: DataTypes.STRING,
		created_at: DataTypes.DATE,
		updated_at: DataTypes.DATE,
        source: DataTypes.STRING,
        email: DataTypes.STRING
	}, {
		timestamps: false
	}, {
		tableName: 'users'
	});

	return Users;
};
