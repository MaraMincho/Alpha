const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('BOOKMARKS', {
    id: {  
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'USERS',
        key: 'id'
      }
    },
    pill_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'PILLS',
        key: 'id'
      }
    }
  }, {
    sequelize,
    tableName: 'BOOKMARKS',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "BOOKMARKS_user_id_USERS_id",
        using: "BTREE",
        fields: [
          { name: "user_id" },
        ]
      },
      {
        name: "BOOKMARKS_pill_id_PILLS_id",
        using: "BTREE",
        fields: [
          { name: "pill_id" },
        ]
      },
    ]
  });
};
