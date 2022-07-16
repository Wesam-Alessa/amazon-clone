import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/features/cart/services/car_services.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(ProductModel productModel) {
    productDetailsServices.addToCart(
        context: context, productModel: productModel);
  }

  void decreaseQuantity(ProductModel productModel) {
    cartServices.removeFromCart(
        context: context, productModel: productModel);
  }

  @override
  Widget build(BuildContext context) {
    final productCart =
        context.watch<UserProvider>().userModel.cart[widget.index];
    final product = ProductModel.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: Dimensions.height30 * 4,
                width: Dimensions.height30 * 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10, top: Dimensions.height10 / 2),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: Dimensions.font16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10, top: Dimensions.height10 / 2),
                    child: Text(
                      "\$${product.price}",
                      style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width10),
                    child: const Text(
                      "Eligible for FREE Shipping",
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10, top: Dimensions.height10 / 2),
                    child: const Text(
                      "In Stock",
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius10 / 2),
                    color: Colors.black12),
                child: Row(
                  children: [
                    InkWell(
                      onTap:() => decreaseQuantity(product),
                      child: Container(
                        width: Dimensions.width15,
                        height: Dimensions.height30,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          size: Dimensions.iconSize18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white),
                      child: Container(
                        width: Dimensions.width15,
                        height: Dimensions.height30,
                        alignment: Alignment.center,
                        child: Text(quantity.toString()),
                      ),
                    ),
                    InkWell(
                      onTap:() => increaseQuantity(product),
                      child: Container(
                        width: Dimensions.width15,
                        height: Dimensions.height30,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          size: Dimensions.iconSize18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
