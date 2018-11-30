const queries = require('../src/queries');
const MysqlManager = require('../src/mysql_manager');

const man = new MysqlManager();
man.connect().then(() => console.log('Connected'));

