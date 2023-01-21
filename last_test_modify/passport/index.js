const passport = require('passport');
const local = require('./localStrategy');
const USERS = require('../models').USERS;

module.exports = () => {
    // 로그인 성공 시 쿠키와 id만 들고있음
    passport.serializeUser((user, done) => {
        // null - 서버 에러
        // user.id - 성공해서 user의 id를 가져옴
        done(null, user.id)
    });

    // 서버에서 유저에 대한 모든 정보를 갖고 있게되면, 서버 과부하 발생.
    // 따라서 서버는 id만 갖고있다가, 페이지 이동 시 필요한 유저 정보는 DB에서 찾아서 가져옴.
    passport.deserializeUser( async (id, done) => { // DB에서 정보를 찾으면 req.user로 넣어줌
        try {
            const user = await USERS.findOne({ where: { id }});
            done(null, user); // done 시 callback
        } catch(error) {
            console.error(error);
            done(error);
        }
    });

    local();
};