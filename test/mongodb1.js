import {MongoClient} from 'mongodb';
import mysql from 'mysql2';
import express from "express";

const client = new MongoClient('mongodb+srv://veromarti:p8zCyUtKKH3Hv6aU@clustervmc.kwxpmvj.mongodb.net/');

await client.connect();

const db = client.db('test2');

const collection = db.collection('test_2');

// const result = await collection.find().toArray();

// const data = await client.db('test').collection('test_1').find().toArray();

// const add = await collection.insertOne({
//     "email":"antony@mail.com",
//     "message":"HE'S GOD"
// });

// await collection.insertOne({
//     "email":"diego@mail.com",
//     "message":"The tutor"
// });


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

app.get('/clients')