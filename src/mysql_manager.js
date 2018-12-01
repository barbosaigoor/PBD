const mysql = require('mysql');

class MysqlManager {
    constructor(options) {
        this.connection = null;
        this.options = options || {
            host: 'localhost',
            user: 'root',
            password: 'sunday',
            database: 'Factory'
        };
    }

    connect() {
        return new Promise((resolve, reject) => {
            this.connection = mysql.createConnection(this.options);
            this.connection.connect(err => err ? reject(err) : resolve());
        });
    }

    query(query) {
        return new Promise((resolve, reject) => {
            this.connection.query(query, (err, results) => err ? reject(err) : resolve(results));
        });
    }

    disconnect() {
        if(this.connection) this.connection.end();
    }
}

module.exports = MysqlManager;