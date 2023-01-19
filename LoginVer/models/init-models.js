var DataTypes = require("sequelize").DataTypes;
var _users = require("./USERS");

function initModels(sequelize) {
  var users = _users(sequelize, DataTypes);


  return {
    users,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
