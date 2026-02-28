import {MongoClient} from "mongodb";

const mongodbClient = new MongoClient('mongodb+srv://veromarti:p8zCyUtKKH3Hv6aU@clustervmc.kwxpmvj.mongodb.net/')

mongodbClient.connect()
    .then(() => {console.log("Connected successfully to MongoDB")})
    .catch((error) => {console.log(("Failed MongoDB"), error)});

const mongodbConnect = await mongodbClient.db('crudzocial').collection('tickets');

const results = await mongodbConnect.find().toArray();

export default mongodbConnect;
