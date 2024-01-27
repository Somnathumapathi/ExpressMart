const express = require('express')
const User = require('../models/user')

const authRouter = express.Router()

authRouter.post("/api/signup", async (req, res) => {
try{
    const {name, email, password} = req.body
 const currentUser = await User.findOne({email})
 if(currentUser) {
    return res.status(400).json({msg:'Email already in use'})
 }
 let user = new User ({
    email, name, password
 })
 user = await user.save()
 res.json(user)
} catch (e) {
    res.status(500).json({error: e.message})
}
})

module.exports = authRouter