const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PILLS', {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
    },
    class: {
      type: DataTypes.STRING(200),
      allowNull: false,
    },
    shape: {
      type: DataTypes.STRING(45),
      allowNull: false,
    },
    company: {
      type: DataTypes.STRING(200),
      allowNull: false,
      
    },
    name: {
      type: DataTypes.STRING(200),
      allowNull: false,
    
    }
  }, {
    sequelize,
    tableName: 'PILLS',
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
