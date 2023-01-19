const {pool} = require('../database/db_config.js')


/**
 *
 * @param {String} name 이름
 * @param {String} nick 닉네임
 * @param {String} password 비밀번호
 * @returns
 */


exports.register = async (name, nick, password) => {
    const query = `INSERT INTO users
  (name, nick, password)
  VALUES (?, ?, ?)`;

    return await pool(query, [name, nick, password]);
}
exports.temp = () => {
    console.log('123')
}