const express = require('express');
const USERS = require('../models').users;
const bcrypt = require('bcrypt');
const passport = require('passport');
const jwt = require('jsonwebtoken');

const router = express.Router();
const { isLoggedIn, isNotLoggedIn } = require('./middlewares');

// 회원가입 
router.post('/signup', async (req, res, next) => {
    try {
        const exEmail = await USERS.findOne({ // 이메일 검사
            where: {
                email: req.body.email,
            }
        });
        const exNickname = await USERS.findOne({ // 닉네임 검사
            where: {
                nick: req.body.nickname,
            }
        });
        if (exEmail) { // 이미 존재하는 이메일이면
            // return으로 res(응답)을 한번만 보내도록 한다. 응답 후 router 종료된다.
            return res.status(403).send('이미 사용중인 이메일입니다.');
        }
        if (exNickname) { // 이미 존재하는 닉네임이면
            return res.status(403).send('이미 사용중인 닉네임입니다.');
        }
        // 비밀번호 해쉬화
        const hashedPassword = await bcrypt.hash(req.body.password, 12);
        // USERS 테이블에 생성
        await USERS.create({
            nick: req.body.nickname,
            email : req.body.email,
            password: hashedPassword,
        });
        // 요청에 대한 성공으로 status(201) 
        res.status(201).send('회원가입 성공!');
    } catch(err) {
        console.error(err);
        next(err); // status(500) - 서버에러
    }
});

router.post('/auth', passport.authenticate('jwt', { session: false}),
    async (req, res, next) => {
        try {
            res.json({ result: true });
        } catch (error) {
            console.error(error);
            next(error);
        }
    });

// 로그인
// 미들웨어 확장법 (req, res, next를 사용하기 위해서)
// passport index.js에서 전달되는 done의 세가지 인자를 받음.
router.post('/login', async (req, res, next) => {
    try {
        // 아까 local로 등록한 인증과정 실행
        passport.authenticate('local', (passportError, user, info) => {
            // 인증이 실패했거나 유저 데이터가 없다면 에러 발생
            if(passportError) {
                console.error(passportError);
                return next(passportError);            }
            else if (!user) {
                res.status(400).json({ message: info.reason });
                return;
            }
            // user데이터를 통해 로그인 진행
            req.login(user, { session: false }, (loginError) => {
                if (loginError) {
                    res.send(loginError);
                    return;
                }
                // 클라이언트에게 JWT생성 후 반환
                const token = jwt.sign(
                    { email: user.email, name: user.nick, auth: user.auth, id:user.id },
                    'jwt-secret-key'
                );
                res.json({ token });
            });
        })(req, res);
    } catch (error) {
        console.error(error);
        next(error);
    }
    // passport.authenticate('local', async (err, user, info) => {
    //     console.log("여기는 되는듯");
    //     if (err) { // 서버 에러
    //         console.error(err);
    //         return next(err);
    //     }
    //     if (info) { // 클라이언트 에러
    //         res.status(403).send(info.reason);
    //     }
    //
    //     const hashedPassword = await bcrypt.hash(req.body.password, 12);
    //
    //     // req.login하면 serializeUser 실행
    //     // 아래는 passport에서 serializeUser 통과 후  if문부터 실행
    //     return req.login(user, async (loginErr) => {
    //         if (loginErr) {
    //             console.error(loginErr);
    //             return next(loginErr);
    //         }
    //         const token = jwt.sign(
    //             {
    //                 type: 'JWT',
    //                 nickname: "nickname",
    //             },
    //             'jwt-secret-key',
    //         );
    //         // 비밀번호를 제외한 모든 정보 전송
    //         const fullUserWithoutPassword = await USERS.findOne({
    //             where: {id: user.id},
    //             // attributes: {
    //             //     exclude: ['password'],
    //             // },
    //         });
    //         // 세션쿠키와 json 데이터를 브라우저로 전송
    //         return res.status(201).json(token);
    //     });
    // })(req, res, next);
});

// 로그아웃
// router.get('/logout', isLoggedIn, (req, res, next) => {
//     req.logout((err) => {
//       if (err) { return next(err); }
//       req.session.destroy();
//       res.send('로그아웃 성공!');
//       res.redirect('/');
//     });
//   });


module.exports = router;