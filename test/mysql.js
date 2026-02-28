import mysql from 'mysql2';


/**
 * host : ip (localhost)
 * port : 3306
 * user: root
 * password : password
 */
const dbconnection = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user:'root',
    password:"password",
    database: "delivery_ops"
});

dbconnection.connect( (error) => {
    if(error){
        console.log("Failed connection")
    }else{
        console.log("Connection succesfull")
    }
});

// function getClients(){
//     const result = dbconnection.query("SELECT * FROM clients;", (error,result) => {
//         console.log(JSON.stringify(result))
//     });
//     return result
// }


// getClients()



dbconnection.query("INSERT INTO clients (full_name,email) VALUES ('Pepe', 'pepe@mail.com');", (error,result) => {
         console.log(JSON.stringify(result))
         console.log(result)

     });

dbconnection.query("INSERT INTO clients (full_name,email) VALUES (?, ?);", ['Diego','diego@mail.com'], (error,result) => {
         console.log(JSON.stringify(result))
         console.log(result)

     });

     const new_name = 'DUVAN'
     const id = 8
dbconnection.query("UPDATE clients SET full_name = ? WHERE id = ?;", 
        [new_name,id], (error,result) => {
         console.log(JSON.stringify(result))
         console.log(result)

     });

dbconnection.query("SELECT * FROM clients;", (error,result) => {
         console.log(JSON.stringify(result))

         result.forEach(client =>{
            console.log(client)
         })
     });


     
dbconnection.end();