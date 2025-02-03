const { gql } = require("graphql-tag");

module.exports = gql`

    type User{
        id: ID!
        username: String!
        email: String!
        role: String!
        token: String
    }

    type Recipe{
        id: ID!
        title : String!
        description: String!
        ingredients: [String]!
        steps: [String]!
        createdBy: User!
        createdAt: String!
    }  
    
    type Query{
        me: User
        users: [User] #Admin Only 
        getRecipes: [Recipe]!
        getRecipe(id: ID!): Recipe
    }

    type Mutation{
        register(username: String!, email: String!, password: String!): User
        login(email: String!, password: String!): User

        addRecipe(title: String!, description: String!, ingredients: [String]!, steps: [String]!): Recipe
        deleteRecipe(id: ID!): Recipe
    }

    
`;