import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/home_screen/widgets/address_box.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart-screen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String searchQurey) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQurey);
  }

  void navigateToAddressScreen(int totalAmount) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,arguments: totalAmount.toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().userModel;
     int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height30 * 2),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: Dimensions.height20 * 2,
                  margin: EdgeInsets.only(left: Dimensions.width15),
                  child: Material(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius15 / 2),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: Dimensions.width10 / 2),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: Dimensions.iconSize24,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.only(top: Dimensions.height10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius15 / 2),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius15 / 2),
                            ),
                            borderSide: const BorderSide(
                                color: Colors.black38, width: 1)),
                        hintText: 'Search Amazon.in',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
                color: Colors.transparent,
                height: Dimensions.height45,
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: Dimensions.iconSize24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
              child: CustomButton(
                  text: 'Proceed to Buy (${user.cart.length}) items',
                  onTap: () => navigateToAddressScreen(sum),
                  color: Colors.yellow[600]),
            ),
            SizedBox(height: Dimensions.height15),
            Container(height: 1, color: Colors.black12.withOpacity(0.08)),
            SizedBox(height: Dimensions.height15 / 3),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
