// import from packages
const express = require("express");
const mongoose = require("mongoose");

// import from auther files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// init
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://wesam:wesam@cluster0.ti1mr.mongodb.net/?retryWrites=true&w=majority";
 
// middleware
app.use(express.json());
app.use("/api/auth",authRouter);
app.use("/api/admin",adminRouter);
app.use(productRouter);
app.use('/api/user',userRouter);


// connections 
mongoose.connect(DB)
    .then(() => {
    console.log("Connection Successfully");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT,"0.0.0.0",() => {
    console.log("Connected at port "+PORT);
});