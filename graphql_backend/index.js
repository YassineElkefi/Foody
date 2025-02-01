require("dotenv").config();
const express = require("express");
const { ApolloServer } = require("@apollo/server");
const { expressMiddleware } = require("@apollo/server/express4");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const typeDefs = require("./src/graphql/typeDefs");
const resolvers = require("./src/graphql/resolvers");
const { authMiddleware } = require("./src/middlewares/authMiddleware");

const app = express();

async function startServer() {
  const server = new ApolloServer({
    typeDefs,
    resolvers,
    introspection: true,
    playground: true
  });

  await server.start();

  app.use(cors());
  app.use(bodyParser.json());

  app.use(
    "/graphql",
    expressMiddleware(server, {
      context: async ({ req }) => {
        return authMiddleware(req);
      }
    })
  );

  try {
    await mongoose.connect(process.env.MONGO_CONNECTION_STRING);
    console.log("Connected to MongoDB");
    
    app.listen(process.env.PORT || 4000, () => {
      console.log(
        `🚀 Server ready at http://localhost:${process.env.PORT || 4000}/graphql`
      );
    });
  } catch (err) {
    console.error("Error starting server:", err);
  }
}

startServer().catch(console.error);