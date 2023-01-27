const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('bookmarks', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'users',
        key: 'id'
      }
    },
    pill_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'pills',
        key: 'id'
      }
    }
  }, {
    sequelize,
    tableName: 'bookmarks',
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
        name: "user_id_idx",
        using: "BTREE",
        fields: [
          { name: "user_id" },
        ]
      },
      {
        name: "pill_id_idx",
        using: "BTREE",
        fields: [
          { name: "pill_id" },
        ]
      },
    ]
  });
};
