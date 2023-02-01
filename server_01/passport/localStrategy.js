const passport = require('passport');
const bcrypt = require('bcrypt');
const users = require('../models').users;



const { ExtractJwt, Strategy: JWTStrategy } = require('passport-jwt');
const { Strategy: LocalStrategy } = require('passport-local');

const passportConfig = { usernameField: 'email', passwordField: 'password' };
const passportVerify = async (email, password, done) => {
    try {
        const user = await users.findOne({ // 로그인 시도에서 이메일 있는 조건으로 검색
            where: { email }
        });
        if (!user) {
            return done(null, false, { reason: '이메일이 일치하지 않습니다.'});
        }
        // 비밀번호 비교 체크
        // 첫번째 인자 password : 사용자가 입력한 비밀번호
        // 두번째 인자 user.password : 실제 DB에 있는 비밀번호
        const result = await bcrypt.compare(password, user.password);
        if (result) { // 비밀번호 일치할 경우
            return done(null, user); // 두번째 user는 성공의 의미
        }
        // 비밀번호 일치하지 않을 경우
        return done(null, false, { reason: '비밀번호가 일치하지 않습니다.' });
    } catch (err) {
        console.error(err);
        return done(err);
    }
}

const JWTConfig = {
    jwtFromRequest: ExtractJwt.fromHeader('authorization'),
    secretOrKey: 'jwt-secret-key',
};

const JWTVerify = async (jwtPayload, done) => {
    try {

        // payload의 id값으로 유저의 데이터 조회
        const user = await users.findOne({ where: { id: jwtPayload.id } });
        // 유저 데이터가 있다면 유저 데이터 객체 전송
        if (user) {
            done(null, user);
            return
        }
        // 유저 데이터가 없을 경우 에러 표시
        done(null, false, { reason: '올바르지 않은 인증정보 입니다.' });
    } catch (error) {
        console.error(error);
        done(error);
    }
};

module.exports = () => {
    passport.use('local', new LocalStrategy(passportConfig, passportVerify));
    passport.use('jwt', new JWTStrategy(JWTConfig, JWTVerify));
};


// local 로그인 전략
// done : 첫번째인자 - 서버 에러 / 두번째인자 - 응답 실패,성공 유무 / 세번째인자 - 실패 시 나타낼 문구(reason: XXXX);
// module.exports = () => {
//     passport.use(new LocalStrategy({
//         usernameField: 'email',
//         passwordField: 'password'
//     }, async (email, password, done) => {
//         try {
//             const user = await users.findOne({ // 로그인 시도에서 이메일 있는 조건으로 검색
//                 where: { email }
//             });
//             if (!user) {
//                 return done(null, false, { reason: '이메일이 일치하지 않습니다.'});
//             }
//             // 비밀번호 비교 체크
//             // 첫번째 인자 password : 사용자가 입력한 비밀번호
//             // 두번째 인자 user.password : 실제 DB에 있는 비밀번호
//             const result = await bcrypt.compare(password, user.password);
//             if (result) { // 비밀번호 일치할 경우
//                 return done(null, user); // 두번째 user는 성공의 의미
//             }
//             // 비밀번호 일치하지 않을 경우
//             return done(null, false, { reason: '비밀번호가 일치하지 않습니다.' });
//         } catch (err) {
//             console.error(err);
//             return done(err);
//         }
//     }));
//
// };