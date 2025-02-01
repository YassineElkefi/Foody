const { gql } = require("graphql-tag");

module.exports = gql`

    type User{
        id: ID!
        username: String!
        email: String!
        role: String!
        token: String
    }

    type Query{
        me: User
        users: [User] #Admin Only 
    }

    type Mutation{
        register(username: String!, email: String!, password: String!): User
        login(email: String!, password: String!): User
    }
`;