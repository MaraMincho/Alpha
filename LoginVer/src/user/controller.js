// routes/user.js
const express = require('express');
const {register, temp} = require('./query');
const {pool} = require("../database/db_config");
const router = express.Router();

router.get('/', async (req, res) => {

    await register(11, 22, 33);

    res.status(201).json(
        {
            "success": '1231312312'
        }
    );
});
router.post('/register', async(req, res) => {

    let {name, nick, password} = req.body
    //await register(name, nick, password)

    const query = `INSERT INTO users
  (name, nick, password)
  VALUES (?, ?, ?)`;
    let temp = await pool(query, [name, nick, password]);


    res.status(201).json({
        "횐갑?" :" 성공~"
    })
})

// router.post('/register', async (req, res) => {
//     let {email, password, name} = req.body
//     console.log(email, password, name)
//
//     let conn = await register(email, password, name);
//
//     res.status(200).json({
//         "conn": '123'
//     })
// });
//
//

// router.get("/", (req, res) => {
//     // db select문 수행
//     db((err, connection) => {
//         connection.query("SELECT * FROM users", (err, rows) => {
//             connection.release(); // 연결세션 반환.
//             if (err) {
//                 throw err;
//             }
//
//             return res.json({ data: rows }); // 결과는 rows에 담아 전송
//         });
//     });
// });




module.exports = router;