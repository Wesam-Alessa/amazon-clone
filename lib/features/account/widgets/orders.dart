import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // List<String> products = [
  //   "https://www.istockphoto.com/resources/images/PhotoFTLP/P2-JUNE-iStock-1324722940.jpg",
  //   "https://www.istockphoto.com/resources/images/PhotoFTLP/P2-JUNE-iStock-1324722940.jpg",
  //   "https://www.istockphoto.com/resources/images/PhotoFTLP/P2-JUNE-iStock-1324722940.jpg",
  //   "https://www.istockphoto.com/resources/images/PhotoFTLP/P2-JUNE-iStock-1324722940.jpg",
  //   "https://www.istockphoto.com/resources/images/PhotoFTLP/P2-JUNE-iStock-1324722940.jpg",
  // ];
  List<OrderModel>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width10),
                    child: Text(
                      'Your Orders',
                      style: TextStyle(
                          fontSize: Dimensions.font18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: Dimensions.width10),
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontSize: Dimensions.font18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Container(
                height: Dimensions.screenHeight * 0.25,
                padding: EdgeInsets.all(Dimensions.width10 / 2),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrderDetailsScreen.routeName,
                            arguments: orders![index]);
                      },
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
