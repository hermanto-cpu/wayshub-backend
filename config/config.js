require('dotenv').config();

module.exports = {
  development: {
    username: process.env.DB_USER || 'user',
    password: process.env.DB_PASSWORD || 'password',
    database: process.env.DB_NAME || 'wayshub',
    host: process.env.DB_HOST || 'database',
    dialect: 'mysql'
  }
};
