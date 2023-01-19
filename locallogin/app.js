const express = require('express');
const session = require('express-session');
const path = require('path');
const morgan = require('morgan');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const dotenv = require('dotenv');
const passportConfig = require('./passport');
const passport = require('passport');

// 제작한 모델 불러오기
const { sequelize } = require('./models/index');

// 라우터 불러오기
const pageRouter = require('./routes/page');
const userRouter = require('./routes/user');

dotenv.config();

const app = express();

sequelize.sync({ force: false })
.then(() => {
    console.log('DB 연결 성공!');
})
.catch((err) => {
    console.error(err);
})

passportConfig(); // passport 내부 js 모듈 실행
app.set('port', process.env.PORT || 3000);

app.use(morgan('dev'));



// json - 클라이언트에서 받은 데이터를 json으로 보내줄 경우 json으로 파싱
app.use(express.json());
// urlencoded - 클라이언트에서 form submit으로 보낼 때 form parsing을 받을 때 쓰인다.
app.use(express.urlencoded({ extended: true }));
app.use(cors({
    origin: 'http://localhost:3000', 
    credentials: true,  // 쿠키 공유를 허락
}));


app.use(cookieParser(process.env.COOKIE_SECRET));

app.use(session({
    resave: false, 
    saveUninitialized: false, 
    secret: process.env.COOKIE_SECRET,
    cookie: {
        httpOnly: false,
    },
    name: "login",
}));
app.use(passport.initialize());
app.use(passport.session());



app.use('/page', pageRouter); 
app.use('/user', userRouter); 


// 404 처리 미들웨어
app.use((req, res, next) => {
    console.log('404 에러');
    res.status(404).send('Not Found');
});

// 에러 처리 미들웨어
app.use((err, req, res, next) => {
    console.error(err);
    res.status(err.status || 500).send(err.message);
});

app.listen(app.get('port'), () => {
    console.log(app.get('port'), '번 포트에서 대기 중...');
});