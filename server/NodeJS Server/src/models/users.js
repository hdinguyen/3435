"use strict";


module.exports = function (sequelize, DataTypes) {
	var Users = sequelize.define("users", {
		firstname: DataTypes.STRING,
		email: DataTypes.STRING,
		address: DataTypes.STRING,
		username: DataTypes.STRING,
		lastname: DataTypes.STRING,
		gender: DataTypes.STRING,
		day_of_birth: DataTypes.DATE,
		city: DataTypes.STRING,
		country_code: DataTypes.STRING,
		profile_picture: DataTypes.STRING,
		about_me: DataTypes.STRING,
		is_artist: DataTypes.INTEGER,
		nb_comment: DataTypes.INTEGER,
		nb_share: DataTypes.INTEGER,
		nb_favorite: DataTypes.INTEGER,
		feature_hash: DataTypes.STRING,
		status: DataTypes.STRING,
		device_id: DataTypes.STRING,
		age: {
			field : "day_of_birth",
			type     : DataTypes.DATE,
			allowNull: true,
			get      : function()  {
				if(this.getDataValue('day_of_birth'))
				{
					 var date = new Date(this.getDataValue('day_of_birth')); 
					 console.log(date.getFullYear());
					 var curr = new Date();
					 return curr.getFullYear() -  date.getFullYear(); 
				}
				else
					return ''; 
			},
		},
		createdAt: {
			field: 'published_date',
			type: DataTypes.DATE
		},
		updatedAt: {
			field: 'lastupdated_date',
			type: DataTypes.DATE
		},
		avatar_face_id: DataTypes.INTEGER
	}, {
		timestamps: false
	}, {
		tableName: 'users'
	});

	return Users;
};
