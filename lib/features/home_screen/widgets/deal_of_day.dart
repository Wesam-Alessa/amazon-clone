import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/features/home_screen/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  bool loading = true;
  ProductModel? productModel;

  @override
  void initState() {
    super.initState();
    fetchDealOfDate().then((_) {
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> fetchDealOfDate() async {
      productModel = await homeServices.fetchDealOfDayProduct(context: context);
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: productModel);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : GestureDetector(
            onTap: navigateToDetailsScreen,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                      left: Dimensions.width10 / 2, top: Dimensions.height15),
                  child: Text(
                    "Deal of the day",
                    style: TextStyle(fontSize: Dimensions.font20),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                if (productModel!.images.isNotEmpty)
                  Image.network(
                    productModel!.images[0],
                    height: Dimensions.screenHeight * 0.235,
                    fit: BoxFit.fitHeight,
                  ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    left: Dimensions.width10 / 2,
                    top: Dimensions.height10 / 2,
                  ),
                  child: Text(
                    "\$${productModel!.price}",
                    style: TextStyle(fontSize: Dimensions.font17),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                      left: Dimensions.width10 / 2,
                      top: Dimensions.height10 / 2,
                      right: Dimensions.width30),
                  child: Text(
                    productModel!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: productModel!.images
                        .map(
                          (image) => Image.network(
                            image,
                            fit: BoxFit.fitWidth,
                            width: Dimensions.height20 * 5,
                            height: Dimensions.height20 * 5,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height15)
                      .copyWith(left: Dimensions.width15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "See all deals",
                    style: TextStyle(
                      color: Colors.cyan[800],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
