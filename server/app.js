const cors = require('cors');
const path = require('path');
const morgan = require('morgan');
const dotenv = require('dotenv');
const express = require('express');
const session = require('express-session');
const cookieParser = require('cookie-parser');

const passport = require('passport');
const passportConfig = require('./passport');

// 제작한 모델 불러오기
const { sequelize } = require('./models/index');

// 라우터 불러오기
const baseRouter = require('./routes/base');                // base 라우터
const pageRouter = require('./routes/page');                // 회원가입, 로그인 라우터
const userRouter = require('./routes/user');                // 로그인 상태 유지 라우터
const pillSearchByImgRouter = require('./routes/pillSearchByImg');    // 이미지로 알약 검색 라우터
const pillSearchByUserRouter = require('./routes/pillSearchByUser') // 직접 검색 라우터
const bookmarkRouter = require('./routes/bookmark');        // 즐겨찾기 라우터
const detailinfoRouter = require('./routes/detailinfo');    // 알약 상세 정보 라우터


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
    resave: false,  //session 변경 되지 않아도 저장
    saveUninitialized: false, 
    secret: process.env.COOKIE_SECRET, //sessionID 암호화 시 사용되는 값
    cookie: {
        httpOnly: false,
    },
    name: "login",
}));


app.use(passport.initialize());
app.use(passport.session());


app.use('/',baseRouter);
app.use('/page', pageRouter); 
app.use('/user', userRouter); 
app.use('/pillSearchByImg',pillSearchByImgRouter);
app.use('/pillSearchByUser',pillSearchByUserRouter);
app.use('/bookmark',bookmarkRouter);
app.use('/detailinfo',detailinfoRouter);

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

