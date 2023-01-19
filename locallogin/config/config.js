const dotenv = require('dotenv');

dotenv.config();

module.exports = 
{
  "development": {
    "username": "pill",
    "password": "preocess.env.MYSQL_PWD",
    "database": "pill",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "test": {
    "username": "pill",
    "password": "preocess.env.MYSQL_PWD",
    "database": "pill",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "username": "pill",
    "password": "preocess.env.MYSQL_PWD",
    "database": "pill",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}

