const passport = require('passport');
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const {jwtkey} = require('../keys')
const USERS = require('../models').USERS;


// 토큰 암호화
const jwtStrategyOption = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: jwtkey,
  };
  
  module.exports = () => {

    // 유효성 검사
    passport.use(new JwtStrategy(jwtStrategyOption, async (jwt_payload, done) => {
        
        try {
         
            const user = await USERS.findOne({ 
              where: { id: jwt_payload.userId },  raw: true 
            });


            if(user){
              return  done(null, user );
            }
            else{
                return  done(null, false );
            }
        } catch (err) {
            console.error(err);
            return  done(err);
          }
       
    }));

  }
  