const mongoose = require("mongoose");
const Joi = require("joi");
const jwt = require("jsonwebtoken");
const { productSchema }=require("./product");

const userSchema = mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim: true
    },
    email:{
        required: true,
        type: String,
        trim: true,
        unique:true,
    },

    password:{ 
        type: String,
        min:6,
        max:255,
        required: true,
    },
    address:{
        type: String,
        default:""
    },
    type:{
        type: String,
        default:"user"
    },
    cart:[
        {
            product: productSchema,
            quantity:{
                type: Number,
                required: true,
            },
        }
    ]

});

userSchema.methods.generateTokens = function () {
    const token = jwt.sign({_id:this._id,isAdmin:this.isAdmin},'privateKey');
    return token;
} 

const User = mongoose.model("User",userSchema);

function userValidate(user){
    const schema = Joi.object().keys({
        name: Joi.string().min(3).max(44).required(),
        email: Joi.string().min(3).max(255).required().email(),
        password: Joi.string().min(8).max(255).required(),
    });
    return schema.validate(user);
};

module.exports.User = User;
module.exports.userValidate = userValidate;
