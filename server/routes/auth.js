const express = require("express");
const bcrypt = require("bcrypt");
const Joi = require("joi");
const _ = require("lodash");
const jwt = require("jsonwebtoken");

const authRouter = express.Router();
const {User, userValidate} = require("../models/user");
var authMiddleware = require("../middleware/auth_middleware");


authRouter.post("/signup",async (req,res)=>{
    try{
        const { error } = userValidate(req.body);
        if(error){
          return res.status(404).send({"Error":error.message});
        }
        const existingUser = await User.findOne({ email:req.body.email });
        if(existingUser){
            return res.status(400).json({msg:"User with same email already exists!"});
        }
        let user = new User( _.pick(req.body,['name','email','password']));
        const saltRounds = 10;
        const salt = await bcrypt.genSalt(saltRounds);
        user.password = await bcrypt.hash(user.password,salt);
        await user.save();
        const token = user.generateTokens();
        //res.header('token',token).send(_.pick(user,['_id','name','email','password']));
        
        res.header('token',token).json({...user._doc});
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
})


authRouter.post("/signin",async(req,res)=>{
    try{
        const { error } = authValidate(req.body);
        if(error){
          return res.status(404).send({"Error":error.message});
        }
        const {email , password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg:"Invalid email or password!"})
        }
        const isMatch = await bcrypt.compare(password,user.password);
        if(!isMatch){
            return res.status(400).json({msg:"Invalid email or password!"})
        }
        const token = user.generateTokens();
        res.header('token',token).json({...user._doc});
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
})

authRouter.post("/tokenIsValid",async(req,res)=>{
    try{
        const token = req.header('token');
        if(!token){
            return res.json(false);
        }
        const verified = jwt.verify(token,'privateKey');
        if(!verified){
            return res.json(false);
        }
        const user = await User.findById(verified._id);
        if(!user){
            return res.json(false);
        }
        res.json(true);
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
})

authRouter.get("/", authMiddleware, async(req,res)=>{
    try{
        const user = await User.findOne(req.user);
        res.header('token',req.token).json({...user._doc});
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
})


function authValidate(req){
    const schema = Joi.object().keys({
        email: Joi.string().min(3).max(255).required().email(),
        password: Joi.string().min(8).max(255).required(),
    });
    return schema.validate(req);
};

module.exports = authRouter;