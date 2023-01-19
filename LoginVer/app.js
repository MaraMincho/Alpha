const express = require('express');
const session = require('express-session');
const passport = require('passport');

const { sequelize } = require('./models');
const passportConfig = require('./passport');

const baseRouter = require('./router/base');
const authRouter = require('./router/auth');


const app = express();

// passport 내부 js 모듈 실행
passportConfig();

// DB 연결
sequelize.sync({ force: false })
  .then(() => {
    console.log('DB connection success!');
  })
  .catch((err) => {
    console.error(err);
  });

// json - 클라이언트에서 받은 데이터를 json으로 보내줄 경우 json으로 파싱
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use(passport.initialize());


app.use('/', baseRouter);
app.use('/auth', authRouter);

// 포트번호 설정
app.set('port', process.env.PORT || 3000);
app.use(express.json());


// 404 처리
app.use((req, res, next) => {
  console.log('404 에러');
  res.status(404).send('Not Found');
});

// 에러 처리 
app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).send(err.message);
});

app.listen(app.get('port'), () => {
  console.log(app.get('port'), "Server running...");
});