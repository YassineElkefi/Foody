const jwt = require('jsonwebtoken');

const authMiddleware = (req) => {
  // Always return an object with at least a null user
  const context = {
    user: null
  };

  const authHeader = req.headers.authorization;
  if (authHeader) {
    const token = authHeader.split(" ")[1];
    try {
      const user = jwt.verify(token, process.env.JWT_SECRET);
      context.user = user;
    } catch (err) {
      console.log('Invalid/Expired token');
    }
  }

  return context;
};

module.exports = { authMiddleware };