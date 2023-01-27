const express = require('express');
const multer = require('multer');
const spawn = require('child_process').spawn;  // javascript에서 다른 언어를 사용할 수 있게 해줌
const path = require('path');   // 운영체제별로 경로 구분자가 달라서 발생하는 문제를 해결하기 위해 사용
const Sequelize = require('sequelize');
const passport = require('passport');
const pills = require('../models').pills;
const bookmarks = require('../models').bookmarks;
const { promises: fs } = require("fs");
const Op = Sequelize.Op;

const router = express.Router();

var storage = multer.diskStorage({       
  // 파일이 저장될 경로
  destination: (req, file, cb) => { cb(null, 'uploads/'); },    
  // uploads 폴더안에 파일이 저장될 때 어떤 이름으로 저장될 것인지 설정 
  filename: (req, file, cb) => { cb(null, `${file.originalname}`); }, 
});

var upload = multer({ storage: storage }).fields([{ name: 'img' }])

// 로그인 하지 않은 경우의 라우터 (비회원)
router.post("/notlogin", (req, res) => {
  upload(req, res, (err) => {
    if (err) {
      return res.json({ success: false, err });
    }

    // 객체를 JSON 문자열로 변환
    const obj = JSON.parse(JSON.stringify(req.files));

    // javascript로 python 스크립트를 실행
    const result = spawn('python', [path.join(__dirname, '..', 'AI', './pilldetectModel.py'),obj.img[0].path]);

    // stdout의 'data'이벤트리스너로 파이썬 파일 실행 결과를 받음
    result.stdout.on('data', async function (data) {
      let pill_list = data.toString();
      const Arr = pill_list.split(',')
      const final = [];

      try {
        for (let i = 0; i < Arr.length - 1; i++) {
          // pills 테이블에 있는 알약 id 검색
          final[i] = await pills.findOne({ where: { id: Arr[i] }, raw: true });
          // images 폴더에 있는 알약 사진 하나씩 읽기
          final[i].image = await fs.readFile(__dirname + '/images' + '/' + Arr[i] + '.jpg',              
            (err, data) => {
              return data;
            }
          )
          // 비회원이므로 즐겨찾기 여부 반환 불가
          final[i].bookMarking = false;

        }
        // 비동기 방식으로 파일 삭제
        fs.unlink(obj.img[0].path);
        // JSON 형식으로 결과 전송
        res.json(final);
      } 
      catch (error){
        console.error(error);
        return next(error);
      }
    });

    // 에러 발생 시, stderr의 'data'이벤트리스너로 실행 결과를 받음
    result.stderr.on('data', function (data) {
      console.log(data.toString());
    });

  });
});

// 로그인 했을 경우의 라우터
router.post("/",  passport.authenticate('local'),(req, res) => {
  upload(req, res, (err) => {
    if (err) {
      return res.json({ success: false, err });
    }

    // 객체를 JSON 문자열로 변환
    const obj = JSON.parse(JSON.stringify(req.files));

    // javascript로 python 스크립트를 실행
    const result = spawn('python', [path.join(__dirname, '..', 'AI', './pilldetectModel.py'),obj.img[0].path]);

    // stdout의 'data'이벤트리스너로 실행 결과를 받음
    result.stdout.on('data', async function (data) {
      let pill_list = data.toString();
      const Arr = pill_list.split(',')
      const final = [];

      try {
        // bookmarks 테이블에서 user_id 탐색
        const bookmark = await bookmarks.findAll({ where: { user_id: req.user.id }, raw: true });
        // flist 참조변수 선언
        const flist = []

        // bookmarks 테이블에서 user_id을 탐색한 후 push
        for (let i = 0; i < Object.keys(bookmark).length; i++) {
          flist.push(bookmark[i].pill_id);
        }

        for (let i = 0; i < Arr.length - 1; i++) {
          // pills 테이블에 있는 알약 id 검색
          final[i] = await pills.findOne({ where: { id: Arr[i] }, raw: true });
          // images 폴더에 있는 알약 사진 하나씩 읽기
          final[i].image = await fs.readFile(__dirname + '/images' + '/' + Arr[i] + '.jpg',          
            (err, data) => {
              return data;
            }

          )
         // 즐겨찾기 여부 반환
          final[i].bookMarking = (flist.indexOf(final[i].id) < 0) ? false : true;

        }
        // 비동기 방식으로 파일 삭제
        fs.unlink(obj.img[0].path);
        // JSON 형식으로 결과 전송
        res.json(final);
      } 
      catch (error){
        console.error(error);
        return next(error);
      }
    }); 

    // 에러 발생 시, stderr의 'data'이벤트리스너로 실행 결과를 받음
    result.stderr.on('data', function (data) {
      console.log(data.toString());
    });

  });





});

module.exports = router;