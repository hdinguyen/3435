"use strict";


module.exports = function (sequelize, DataTypes) {
	var Categories = sequelize.define("categories", {
		parent_id: DataTypes.INTEGER,
		type: DataTypes.INTEGER,
		priority: DataTypes.INTEGER,
		img_url: DataTypes.STRING,
		title: DataTypes.STRING,
		created_at: DataTypes.DATE,
		updated_at: DataTypes.DATE
	}, {
		timestamps: false
	}, {
		tableName: 'categories'
	});

	return Categories;
};
