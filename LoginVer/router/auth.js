const express = require('express');
const passport = require('passport');
const jwt = require('jsonwebtoken');
const { jwtkey } = require('../keys')
const bcrypt = require('bcrypt');
const { isLoggedIn, isNotLoggedIn } = require('./middlewares');
const USERS = require('../models').USERS;


const router = express.Router();

// 회원가입 
router.post('/signup', isNotLoggedIn, async (req, res, next) => {
  const { name, nick, password, isExistId } = req.body;  // name:사용자 이름, nick:사용자 ID, password:비밀번호
  try {
    if (isExistId) {          // 만약 존재하는 아이디라면
      res.status(403).json({
        "signup": false
      });
    }
    else {                    // 아니라면
      const hash = await bcrypt.hash(password, 12);  // 비밀번호 해쉬화
      await USERS.create({        // users 테이블에 생성하기
        name,
        nick,
        password: hash,
      });
      res.status(201).json({   // 요청에 대한 성공으로 status(201) : 생성이 됐다는 의미
        "signup": true
      });
    }
  } catch (error) {
    console.error(error);
    return next(error);
  }
});

// 로그인
// 미들웨어 확장법 (req, res, next를 사용하기 위해서)
// passport index.js에서 전달되는 done의 세가지 인자를 받음.
router.post('/login', isNotLoggedIn, (req, res, next) => {
  passport.authenticate('local', (err, user, info) => {
    if (err) {
      console.error(err);
      return next(err);
    }
    if (!user) {
      return res.status(403).json(
        {
          "isLogin":false,
        }
      );
    }
       // req.login하면 serializeUser 실행
      // 아래는 passport에서 serializeUser 통과 후  if문부터 실행
    return req.login(user,  async (loginError) => {
      try {
      if (loginError) {
        console.error(loginError);
        return next(loginError);
      }
      const token = jwt.sign({ userId: user.id }, jwtkey);
     
      res.status(201).json(
        {
          "isLogin":true,
          "token": token,
          "name": user.name,
        }
      );
      }
      catch {
        console.error(error);
    return next(error);
      }
    });
  })(req, res, next);
});



router.get('/test', passport.authenticate('jwt', { session: false }),
  (req, res) => {
    res.status(201).json({
      "success": true
    });
  }
);

router.post('/isExistId', async (req, res, next) => {
  try {
    const exUser = await USERS.findOne({ where: { nick: req.body.nick } });
    if (exUser) {
      res.status(201).json(
        {
          "isExistId": true
        }
      )
    }
    else {
      res.status(403).json(
        {
          "isExistId": false
        }
      )
    }
  } catch {
    console.error(error);
    done(error);
  }
});


module.exports = router;


