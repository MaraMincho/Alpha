const passport = require('passport');
const local = require('./localStrategy');
const jwt = require('./jwtStrategy');
const User = require('../models').User;


module.exports = () => {
  passport.serializeUser((user, done) => {
    done(null, user.id);
  });

  passport.deserializeUser((id, done) => {
    User.findOne({ 
      where: { id } 
    })
      .then(user => done(null, user))
      .catch(err => done(err));
  });


  jwt();
  local();
 
};