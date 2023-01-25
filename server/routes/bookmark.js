const express = require('express');
const passport = require('passport');
const USERS = require('../models').USERS;
const PILLS = require('../models').PILLS;
const BOOKMARKS = require('../models').BOOKMARKS;
const { promises: fs } = require("fs");

const router = express.Router();

router.post('/', passport.authenticate('local'),    // 회원 인증이 됐다면
  async (req, res, next) => {
    const { pillId, bookMarking } = req.body;
    try {
    if (bookMarking) {      // bookMarking : ture일 때

      await BOOKMARKS.create({              // BOOKMARKS 테이블에 생성
        pill_id: parseInt(pillId) ,         // 알약 고유 번호
        user_id: parseInt(req.user.id),     // 사용자 고유 번호
      });
      res.status(201).json({
        "create": true                      // 요청에 대한 성공으로 status(201) 
      });
    }
    else {                // bookMarking : false일 때
      await BOOKMARKS.destroy({where: {    // BOOKMARKS 테이블에서 삭제
        pill_id:pillId,                    // 알약 고유 번호
        user_id:req.user.id                // 사용자 고유 번호
      }});
      res.status(201).json({               // 요청에 대한 성공으로 status(201) 
        "delete": true
      });
    }
  }
  catch (error){
    console.error(error);
    return next(error);
  }
    
  }
);

router.get('/', passport.authenticate('local'),
async (req, res, next)=> {
  try{
    const numOfPill = await BOOKMARKS.count({     // 알약 즐겨찾기 갯수 
        where: {user_id:req.user.id}
    });
    res.status(201).json({                        // 알약 갯수와 사용자 이름 res
      "numOfPill": numOfPill,
      "name":req.user.name
    });
  }
  catch {
    console.error(error);
    return next(error);
  }
    
  }
);

router.get('/my', passport.authenticate('local'),     // 회원 인증이 됐다면
async (req, res, next)=> {
  const result = [];
  try{

    const bookmark =  await BOOKMARKS.findAll({       // 나의 즐겨찾기 목록 탐색
        where : {  user_id:req.user.id  }, raw: true
    } );
   

    for(let i = 0;i<Object.keys(bookmark).length;i++){
        result[i] = await PILLS.findOne({
            where : {  id: bookmark[i].pill_id  }, raw: true
        } )
        result[i].image= await fs.readFile(__dirname + '/images'+'/'+bookmark[i].pill_id +'.jpg',             
             (err, data) =>
            {
                
                return data;
    
            }
        )
    }
    result.push(req.user.name);
    res.json(result);
  }
  catch {
    console.error(error);
    return next(error);
  }
    
  }
);

module.exports = router;