const express  = require('express');
const passport = require('passport');
const router = express.Router();
const sequelize = require('../models').sequelize;
const pills = require('../models').pills;
const bookmarks = require('../models').bookmarks;
const { promises: fs } = require("fs");
const path = require('path');
const Sequelize = require('sequelize');
const Op = Sequelize.Op;

// 로그인 하지 않았을 경우(비회원)
router.get('/notlogin',  async (req, res) => {	

	const pillText = req.query.pillText;	// 알약에 새겨진 글씨
    const pillColor = req.query.pillColor;	// 알약 색깔
	const pillForm = req.query.pillForm;	// 알약 모양


    try {
       
        const pillInfo = await pills.findAll({ 		// DB에서 해당하는 column에서 각각 속성 검색
			where: { 
				text:{ [Op.like]: "%" + pillText + "%" },	// 알약에 새겨진 글씨
				color: pillColor, // 알약 색깔
				form: pillForm  // 알약 모양
			}, raw: true });


			for (let i = 0; i < Object.keys( pillInfo).length; i++) {	// 결괏값 사진과 함께 반환

            pillInfo[i].image = await fs.readFile(__dirname + '/images' + '/' + pillInfo[i].id + '.jpg',              //파일 읽기
                (err, data) => {
					if (err) {
						console.error(err);
					  }
					  else{
                    console.log(data)
                    return data;
					  }
                }
            )

            pillInfo[i].bookMarking = false ;	// 즐겨찾기 여부 반환 불가
        }

		// JSON 형식으로 결과 전송
        res.json(pillInfo); 	

    }
    catch (error) {
        console.error(error);
        done(error);
    }


});

// 로그인 했을 경우
router.get('/', passport.authenticate('local'), async (req, res) => {
   
	const pillText = req.query.pillText; // 알약에 새겨진 글씨
    const pillColor = req.query.pillColor; // 알약 색깔
	const pillForm = req.query.pillForm; // 알약 모양
 
	 try {
		// bookmarks 테이블에서 user_id 탐색
	 const bookmark =  await bookmarks.findAll({where : {  user_id:req.user.id  }, raw: true} );
	// flist 참조변수 선언
	 const flist = []		

	// bookmarks 테이블에서 user_id을 탐색한 후 push
	 for(let i = 0;i<Object.keys(bookmark).length;i++){
		 flist.push(bookmark[i].pill_id);
	 }
	 // pills 테이블에 있는 알약 id 검색
	 const pillInfo = await pills.findAll({
		where : {
			text:{ [Op.like]: "%" + pillText + "%" },// 알약에 새겨진 글씨
			color: { [Op.like]: "%" + pillColor + "%" },// 알약 색깔
			form: { [Op.like]: "%" + pillForm + "%" } // 알약 모양
	}, raw: true} );
 
	 
	 for(let i = 0;i<Object.keys(pillInfo).length;i++){
		 
		 pillInfo[i].image= await fs.readFile(__dirname + '/images'+'/'+pillInfo[i].id+'.jpg',           
			  (err, data) =>{
			  if (err) {
				console.error(err);
			  }
			  else{
			console.log(data)
			return data;
			  }
			})
		// 즐겨찾기 여부 반환	 
		 pillInfo[i].bookMarking = (flist.indexOf(pillInfo[i].id) < 0) ? false : true;
	 }
	 
	 // JSON 형식으로 결과 전송
	 res.json(pillInfo);
 
	 }
	 catch(error) {
		 console.error(error);
		  done(error);
	 }
 
 
	 });

module.exports = router;