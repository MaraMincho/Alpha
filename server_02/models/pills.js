const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('pills', {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    class: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    company: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    name: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    text: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    color: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    form: {
      type: DataTypes.STRING(100),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'pills',
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
    ]
  });
};
