require('dotenv').config();
const mysql = require('mysql2');

exports.connection = mysql.createPool(
    {
        host: process.env.DB_HOST,
        user: process.env.DB_USERNAME,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DATABASE,
        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0
    }
);

/**
 * 조금 더 간단하게 connection pool을 사용할 수 있도록 만든 함수입니다.
 * @param {String} queryString 쿼리 문자열
 * @param {array} params    쿼리 ? 에 들어갈 파라미터들
 * @returns
 */
exports.pool = (queryString, params) => {
    return new Promise((resolve, reject) => {
        this.connection.query(queryString, params, (err, rows, fields) =>{
            (err) ? reject(err) : resolve(rows);
        });
    })
}
