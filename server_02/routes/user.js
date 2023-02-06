// const express = require('express');
// const router = express.Router();
// const users = require('../models').users;
// const { isLoggedIn, isNotLoggedIn } = require('./middlewares');
//
// // 로그인 상태 유지를 위한 사용자 정보 가져오기
// router.get('/', isLoggedIn, async (req, res, next) => {
//     try {
//         if (req.user) { // req.user = 로그인한 user 정보
//             const user = await users.findOne({
//                 where: { id: req.user.id }
//             });
//             // 비밀번호를 제외한 모든 정보
//             const fullUserWithoutPassword = await users.findOne({
//                 where: { id: user.id },
//                 attributes: {
//                     exclude: ['password'],
//                 },
//             });
//             res.status(201).json(fullUserWithoutPassword);
//         } else {
//             res.status(201).json(null);
//         }
//     } catch(error) {
//         console.error(error);
//         next(error);
//     }
// });
//
// module.exports = router;