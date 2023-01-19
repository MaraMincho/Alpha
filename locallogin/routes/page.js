const express = require('express');
const { USERS } = require('../models');
const bcrypt = require('bcrypt');
const passport = require('passport');

const router = express.Router();
const { isLoggedIn, isNotLoggedIn } = require('./middlewares');

// 회원가입 
// POST /signup
router.post('/signup', isNotLoggedIn, async (req, res, next) => { // POST /signup/
    try {
        const exEmail = await USERS.findOne({ // 이메일 검사
            where: {
                email: req.body.email,
            }
        });
        const exNickname = await USERS.findOne({ // 이메일 검사
            where: {
                nick: req.body.nickname,
            }
        });
        if (exEmail) { // 이메일 검사 후 이메일이 기존에 있다면?
            // return으로 res(응답)을 한번만 보내도록 한다. 응답 후 router 종료된다.
            return res.status(403).send('이미 사용중인 이메일입니다.');
        }
        if (exNickname) { // 이메일 검사 후 닉네임이 기존에 있다면?
            return res.status(403).send('이미 사용중인 닉네임입니다.');
        }
        // 비밀번호 해쉬화하기
        const hashedPassword = await bcrypt.hash(req.body.password, 12);
        // USERS 테이블에 생성하기
        await USERS.create({
            id:req.body.id,
            nick: req.body.nickname,
            email : req.body.email,
            password: hashedPassword,
        });
        // 요청에 대한 성공으로 status(201) : 생성이 됐다는 의미 (기재하는게 좋다.)
        res.status(201).send('회원가입 성공!');
    } catch(err) {
        console.error(err);
        next(err); // status(500) - 서버에러
    }
});

// 로그인
// 미들웨어 확장법 (req, res, next를 사용하기 위해서)
// passport index.js에서 전달되는 done의 세가지 인자를 받는다.
router.post('/login', isNotLoggedIn, (req, res, next) => {
    passport.authenticate('local', (err, user, info) => {
        if (err) { // 서버 에러
            console.error(err);
            return next(err);
        }
        if (info) { // 클라이언트 에러 
            res.status(403).send(info.reason);
        }
        // req.login하면 serializeUser 실행
        // 아래는 passport에서 serializeUser 통과 후  if문부터 실행
        return req.login(user, async (loginErr) => {
            if (loginErr) {
                console.error(loginErr);
                return next(loginErr);
            }
            // 비밀번호를 제외한 모든 정보 가져오기
            const fullUserWithoutPassword = await USERS.findOne({
                where: { id: user.id },
                attributes: {
                    exclude: ['password'], // exclude: 제외한 나머지 정보 가져오기
                },
            });
            // 세션쿠키와 json 데이터를 브라우저로 전송
            return res.status(200).json(fullUserWithoutPassword);
        });
    })(req, res, next);
});

// 로그아웃
router.get('/logout', isLoggedIn, (req, res, next) => {
    req.logout((err) => {
      if (err) { return next(err); }
      req.session.destroy();
      res.send('로그아웃 성공');
      res.redirect('/');
    });
  });


module.exports = router;