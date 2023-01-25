const path = require('path');
const convert = require('xml-js');
const express = require('express');
const passport = require('passport');
const Sequelize = require('sequelize');
const PILLS = require('../models').PILLS;
const BOOKMARKS = require('../models').BOOKMARKS;
const { promises: fs } = require("fs");
const spawn = require('child_process').spawn;
const request = require('request');
const Op = Sequelize.Op;

require('dotenv').config();

const router = express.Router();

const url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';

// DB 알약기본정보(로그인 하지 않았을 경우)
router.post('/notlogin',  async (req, res) => {         

    // pillID 값 받아오기
    const { pillId } = req.body;    

    try {
        // DB에서 pillId 데이터 select
        const pillInfo = await PILLS.findOne({ where: { id: pillId }, raw: true });     
        // 해당 고유번호를 가진 알약의 사진을 가져오기
        pillInfo.image = await fs.readFile(__dirname + '/images' + '/' + pillId + '.jpg',            
            (err, data) => {

                return data;

            }
        )
        // 비회원이므로 즐겨찾기 여부 반환 불가
        pillInfo.bookMarking =  false ;
        // JSON 형식으로 데이터 반환
        res.json(pillInfo);
    }
    catch (error) {
        console.error(error);
        done(error);
    }


});

// DB 알약기본정보(로그인 했을 경우)
router.post('/', passport.authenticate('local'), async (req, res) => {      

    // pillID 값 받아오기
    const { pillId } = req.body;
    
    try {
        // BOOKMARKS 테이블에서 user_id 검색
        const BOOKMARKS =  await BOOKMARKS.findAll({where : {  user_id:req.user.id  }, raw: true} );
        // plist 초기화
        const plist = []
        // plist에 pill_id 추가
        for(let i = 0;i<Object.keys(BOOKMARKS).length;i++){
            plist.push(BOOKMARKS[i].pill_id);
        }
        // PILLS 테이블에서 pillid 검색
        const pillInfo = await PILLS.findOne({ where: { id: pillId }, raw: true });
        //알약 사진 반환
        pillInfo.image = await fs.readFile(__dirname + '/images' + '/' + pillId + '.jpg',             
            (err, data) => {

                return data;

            }
        )
        // 즐겨찾기 여부 반환
        pillInfo.bookMarking = (plist.indexOf(pillInfo.id) < 0) ? false : true;
         // JSON 형식으로 데이터 반환
        res.json(pillInfo);
    }
    catch (error) {
        console.error(error);
        done(error);
    }
});

// 알약 상세정보 html 코드
router.post('/fromapi', async (req, res) => {
    // pillID 값 받아오기
    const { pillId } = req.body;

    // API 서비스 키 입력
    let queryParams = '?' + encodeURIComponent('ServiceKey') + '='+process.env.API_KEY;
    try {  
        // itemSeq(품목기준코드)
        queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(pillId); 
        // 공공데이터 포털의 xml 데이터를 받아와 JSON으로 파싱
        request({
            url: url + queryParams,
            method: 'GET'
        }, function (error, response, body) {
            // xml -> json
            // 데이터 간소화, 들여쓰기 spaces : 4
            const xmlToJson = convert.xml2json(body, {compact: true, spaces: 4});
            res.send(xmlToJson);
        });//
    }
    catch (error) {
        console.error(error);
        done(error);
    }
});

module.exports = router;