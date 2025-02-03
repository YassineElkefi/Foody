const bcrypt = require('bcryptjs');
const User = require('../models/User');
const Recipe = require('../models/Recipe');
const { generateToken } = require('../utils/auth');
const { Query, get } = require('mongoose');
const { GraphQLError } = require('graphql');
module.exports = {
    Query: {

        //Users Queries
        me: async (_, __, { user }) => {
            if(!user) throw new Error('You are not authenticated');
            return await User.findById(user.id);
        },
        users: async (_, __ , { user }) =>{
            if (!user || user.role !== "ROLE_ADMIN" ) throw new Error('Aceess Denied');
            return await User.find();
        },

        //Recipes Queries
        getRecipes: async () => await Recipe.find().populate('createdBy'),
        getRecipe: async (_, { id }) => await Recipe.findById(id).populate('createdBy'),
    },

    Mutation: {
        //User Mutations
        register: async (_, { username, email, password}) =>{
            const existingUser = await User.findOne( { email });
            if(existingUser) throw new Error('User already exists');

            const hashedPassword = await bcrypt.hash(password, 10);
            const newUser = new User({
                username,
                email,
                password: hashedPassword,
            });
            await newUser.save();

            const token = generateToken(newUser);
            return { ...newUser._doc, id: newUser._id, token};
        },

        login: async (_, { email, password }) =>{
            const user = await User.findOne({ email });
            if(!user) throw new Error('Invalid credentials');

            const validPassword = await bcrypt.compare(password, user.password);
            if (!validPassword) throw new Error('Invalid credentials');

            const token = generateToken(user);
            return { ...user._doc, id: user._id, token};
        },

        //Recipe Mutations

        addRecipe: async (_, { title, description, ingredients, steps}, {user}) =>{
            if (!user || user.role !== "ROLE_USER") throw new GraphQLError("Only users can add recipes", { extensions: { code: "FORBIDDEN"}});

            const recipe = new Recipe({
                title,
                description,
                ingredients,
                steps,
                createdBy: user.id,
                createdAt: new Date().toISOString(),
            });
            await recipe.save();
            return recipe.populate('createdBy');
        }
    },
};