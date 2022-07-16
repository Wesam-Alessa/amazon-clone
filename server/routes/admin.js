const express = require("express");
const adminRouter = express.Router();
var adminMiddleware = require("../middleware/admin_middleware");
const {Product} = require("../models/product");
const Order = require("../models/order");


adminRouter.post("/add-product", adminMiddleware, async(req,res)=>{
    try {
         const {name,description,price,quantity,category,images} = req.body;
         let product = Product({name,description,price,quantity,category,images});       
         const pro = await product.save();
         res.json(pro);
    } catch (e ) {
        res.status(500).json({error:e.message});
    }
});

adminRouter.get("/get-products",adminMiddleware,async(req,res)=>{
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e ) {
         res.status(500).json({error:e.message});
    }

});

adminRouter.get("/get-orders",adminMiddleware,async(req,res)=>{
    try {
        const orders = await Order.find({});
        res.json(orders);
    } catch (e ) {
         res.status(500).json({error:e.message});
    }

});

adminRouter.post("/change-order-status",adminMiddleware, async( req , res )=>{
    try {
        const {id, status} = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    } catch (e ) {
         res.status(500).json({error:e.message});
    }

});

adminRouter.post("/delete-product",adminMiddleware, async( req , res )=>{
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e ) {
         res.status(500).json({error:e.message});
    }

});

adminRouter.get("/analytics", adminMiddleware, async(req, res)=>{
    try{
        const orders = await Order.find({});
        let totalEarnings = 0;
        for(let i = 0; i < orders.length; i++){
            for(let j = 0; j<orders[i].products.length; j++){
                totalEarnings += orders[i].products[j].quantity * orders[i].products[j].product.price ;
            }
        }
        let mobilesEarnings = await fetchCategoryWiseProduct('Mobiles');
        let essentialEarnings = await fetchCategoryWiseProduct('Essentials');
        let applianceEarnings = await fetchCategoryWiseProduct('Appliances');
        let booksEarnings = await fetchCategoryWiseProduct('Books');
        let fashionEarnings = await fetchCategoryWiseProduct('Fashion');
        let earnings = {totalEarnings,mobilesEarnings,essentialEarnings,applianceEarnings,booksEarnings,fashionEarnings,};
        
        res.json(earnings);
    } catch (e ) {
        res.status(500).json({error:e.message});
    }
});

async function fetchCategoryWiseProduct(category){
    let earnings = 0;
    let categoryOrders = await Order.find({
        "products.product.category": category,
    });
    for(let i = 0; i < categoryOrders.length; i++){
        for(let j = 0; j<categoryOrders[i].products.length; j++){
            earnings += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price ;
        }
    }
    return earnings;
}

module.exports = adminRouter;
