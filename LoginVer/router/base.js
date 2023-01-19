const express = require('express')
const router = express.Router()

router.get('/', (req, res) => {
  res.status(201).json(
    {
      success: true
    }
  )
})

module.exports = router
