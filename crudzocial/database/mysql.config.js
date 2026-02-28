/**
 * mysql
 * host
 * port
 * user
 * password
 */

import mysql from 'mysql2';

const mysqlConnect = mysql.createConnection(
    {
        host: "localhost",
        user:'root',
        password:"password",
        database: "posts_system"
    }
)

mysqlConnect.connect((error) => {
    if (!error) {
        console.log('Connected successfully to MySQL')
    } else {
        console.log(("Failed MongoDB"), error)
    }
});

// mysqlConnect.query('SELECT * FROM users;',(error,result) =>)

    export default mysqlConnect;