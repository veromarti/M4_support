import express from 'express';
import mysql from 'mysql2'

const app = express(); //servicio alojado en puerto 3500

//PRIMERA FORMA
// app.get("/clients");

// app.listen('3500', (error) => {
//     if(!error){console.log("Port 3500 Found")};
//     console.log("server running on localhost:3500")
// })

//SEGUNDA FORMA
// app.get("/clients", (request,response) => {
//     response.json({'message':'nice'})
// });

// app.listen('3500', (error) => {
//     if(!error){console.log("Port 3500 Found")};
//     console.log("server running on localhost:3500")
// })

//TERCERA FORMA
// const dbconnection = mysql.createConnection({
//     host: "localhost",
//     port: 3306,
//     user:'root',
//     password:"password",
//     database: "delivery_ops"
// });

// dbconnection.connect( (error) => {
//     if(error){
//         console.log("Failed connection")
//     }else{
//         console.log("Connection succesfull")
//     }

//  });

// app.get("/clients", (request,response) => {
//     dbconnection.query("SELECT * FROM clients;", (error,result) => {
//          response.json(result)
//      });

// });

// app.listen('3500', (error) => {
//     if(!error){console.log("Port 3500 Found")};
//     console.log("server running on localhost:3500")
// })


//CUARTA FORMA
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

 app.get("/clients", (request,response) => {
    dbconnection.query("SELECT * FROM clients;", (error,result) => {
         response.json(result)
     });

});

app.get("/clients/:id", (request,response) => {

    const id = request.params.id;

    dbconnection.query("SELECT * FROM clients WHERE id = ?;"[id], (error,result) => {
         response.json(result)
     });

});

app.listen('3500', (error) => {
    if(!error){console.log("Port 3500 Found")};
    console.log("server running on localhost:3500")
})
