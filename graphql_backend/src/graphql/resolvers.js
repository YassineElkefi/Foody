const bcrypt = require('bcryptjs');
const User = require('../models/User');
const { generateToken } = require('../utils/auth');
module.exports = {
    Query: {
        me: async (_, __, { user }) => {
            if(!user) throw new Error('You are not authenticated');
            return await User.findById(user.id);
        },
        users: async (_, __ , { user }) =>{
            if (!user || user.role !== "ROLE_ADMIN" ) throw new Error('Aceess Denied');
            return await User.find();
        }
    },

    Mutation: {
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
    },
};