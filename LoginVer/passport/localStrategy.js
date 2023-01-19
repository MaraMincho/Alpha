const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const bcrypt = require('bcrypt');
const user = require('../models').user;


// local 로그인 전략
// done : 첫번째인자 - 서버 에러 / 두번째인자 - 응답 실패,성공 유무 / 세번째인자 - 실패 시 나타낼 문구(reason: XXXX);
module.exports = () => {
  passport.use(new LocalStrategy({
    usernameField: 'nick',
    passwordField: 'password',
  }, async (nick, password, done) => {
    try {
      const exUser = await user.findOne({ 
        where: { nick: nick } 
      });

         // 비밀번호 비교 체크
            // 첫번째 인자 password : 사용자가 입력한 비밀번호
            // 두번째 인자 user.password : 실제 DB에 있는 비밀번호
      if (exUser) {  
        const result = await bcrypt.compare(password, exUser.password);
        if (result) {     // 비밀번호 일치할 경우
          done(null, exUser);    // exUser는 성공의 의미
        } 
        else {                // 비밀번호 일치하지 않을 경우
          done(null, false, { reason: '비밀번호가 틀렸습니다.' });
        }
      } else {
        done(null, false, { reason: '회원가입이 필요합니다.' });
      }
    } catch (err) {
      console.error(err);
      done(err);
    }
  }));
};
