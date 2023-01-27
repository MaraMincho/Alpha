var DataTypes = require("sequelize").DataTypes;
var _bookmarks = require("./bookmarks");
var _pills = require("./pills");
var _users = require("./users");

function initModels(sequelize) {
  var bookmarks = _bookmarks(sequelize, DataTypes);
  var pills = _pills(sequelize, DataTypes);
  var users = _users(sequelize, DataTypes);

  bookmarks.belongsTo(pills, { as: "pill", foreignKey: "pill_id"});
  pills.hasMany(bookmarks, { as: "bookmarks", foreignKey: "pill_id"});
  bookmarks.belongsTo(users, { as: "user", foreignKey: "user_id"});
  users.hasMany(bookmarks, { as: "bookmarks", foreignKey: "user_id"});

  return {
    bookmarks,
    pills,
    users,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
