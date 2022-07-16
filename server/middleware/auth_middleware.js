const jwt = require("jsonwebtoken");

const authMiddleware = async (req,res,next) => {
    try {
        const token = req.header("token");
        if(!token){
            return res.status(401).json({msg:"No auth token, access denid!"});
        }
        const verified = jwt.verify(token,'privateKey');
        if(!verified){
            return res.status(401).json({msg:"Token verification failed, authorization denid!"});
        }
        req.user = {_id:verified._id};
        req.token = token;
        next();
    } catch (err) {
        return res.status(500).json({error:err.message});
    }
};
module.exports = authMiddleware;