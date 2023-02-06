const path = require('path');
const convert = require('xml-js');
const express = require('express');
const passport = require('passport');
const Sequelize = require('sequelize');
const pills = require('../models').pills;
const bookmarks = require('../models').bookmarks;
const { promises: fs } = require("fs");
const spawn = require('child_process').spawn;
const request = require('request');
const {set} = require("express/lib/application");
const Op = Sequelize.Op;
const DomParser = require('dom-parser');


require('dotenv').config();

const router = express.Router();

const url = 'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList';

// DB 알약기본정보(로그인 하지 않았을 경우)
router.get('/notlogin',  async (req, res) => {

    // pillID 값 받아오기
    const { id } = req.query;
    if (!id) {
        res.status(400);
        res.json({message: 'require id for querry'})
    }
    try {
        // DB에서 pillId 데이터 select
        const pillInfo = await pills.findOne({ where: { id: id }, raw: true });
        // 해당 고유번호를 가진 알약의 사진을 가져오기
        pillInfo.image = await fs.readFile(__dirname + '/images' + '/' + id + '.jpg',
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
        res.status(400);
        res.json({error})
    }

});

// DB 알약기본정보(로그인 했을 경우)
router.get('/', passport.authenticate('jwt',{ session: false }),
    async (req, res, ) => {
        // pillID 값 받아오기
        const { id } = req.query;
        try {
            // bookmarks 테이블에서 user_id 검색
            const bookmark =  await bookmarks.findAll({where : { user_id : req.user.id }, raw: true} );
            // plist 초기화
            const plist = []
            // plist에 pill_id 추가
            for(let i = 0; i < Object.keys(bookmark).length; i++){
                plist.push(bookmark[i].pill_id);
            }
            //검색시 자동 북마크 추가 만약 알약이 북마크에 이미 존재하면 pass
            if (!plist.includes(parseInt(id))) {
                await bookmarks.create({
                    user_id: req.user.id,
                    pill_id: id
                });
                console.log("추가");
            }


            // pills 테이블에서 pillid 검색
            const pillInfo = await pills.findOne({ where: { id: id }, raw: true });
            //알약 사진 반환
            pillInfo.image = await fs.readFile(__dirname + '/images' + '/' + id + '.jpg',
                (err, data) => {
                    return data;
                }
            )
            // 즐겨찾기 여부 반환
            pillInfo.bookMarking = (plist.indexOf(pillInfo.id) < 0) ? false : true; //? 코드 실행 안되는 것 같음...
            // JSON 형식으로 데이터 반환
            res.json(pillInfo);
        }
        catch (error) {
            console.error(error);
            done(error);
        }
    });

// 알약 상세정보 html 코드
router.get('/fromapi', async (req, res) => {
    // pillID 값 받아오기
    const { id } = req.query;

    // API 서비스 키 입력
    let queryParams = '?' + encodeURIComponent('ServiceKey') + '=' + process.env.API_KEY;
    try {
        // itemSeq(품목기준코드)
        queryParams += '&' + encodeURIComponent('itemSeq') + '=' + encodeURIComponent(id);
        // 공공데이터 포털의 xml 데이터를 받아와 JSON으로 파싱
        request({
            url: url + queryParams,
            method: 'GET'
        }, function (error, response, body) {
            // xml -> json
            // 데이터 간소화, 들여쓰기 spaces : 4
            let parseXML = new DomParser();
            let xmlDoc = parseXML.parseFromString(body);
            let entpName = xmlDoc.getElementsByTagName("entpName")[0].textContent;
            let itemName = xmlDoc.getElementsByTagName("itemName")[0].textContent;
            let itemSeq = xmlDoc.getElementsByTagName("itemSeq")[0].textContent;
            let efcyQesitm = xmlDoc.getElementsByTagName("efcyQesitm")[0].textContent;
            let useMethodQesitm = xmlDoc.getElementsByTagName("useMethodQesitm")[0].textContent;
            let atpnWarnQesitm = xmlDoc.getElementsByTagName("atpnWarnQesitm")[0].textContent;
            let atpnQesitm = xmlDoc.getElementsByTagName("atpnQesitm")[0].textContent;
            let intrcQesitm = xmlDoc.getElementsByTagName("intrcQesitm")[0].textContent;
            let seQesitm = xmlDoc.getElementsByTagName("seQesitm")[0].textContent;
            let depositMethodQesitm = xmlDoc.getElementsByTagName("depositMethodQesitm")[0].textContent;
            //const xmlToJson = convert.xml2json(body, {compact: true});
            res.json({
                "entpName" : entpName,
                "itemName" : itemName,
                "itemSeq" : itemSeq,
                "efcyQesitm" : efcyQesitm,
                "useMethodQesitm" : useMethodQesitm,
                "atpnWarnQesitm" : atpnWarnQesitm,
                "atpnQesitm" : atpnQesitm,
                "intrcQesitm" : intrcQesitm,
                "seQesitm" : seQesitm,
                "depositMethodQesitm" : depositMethodQesitm
            })
        });//
    }
    catch (error) {
        console.error(error);
        done(error);
    }
});

module.exports = router;