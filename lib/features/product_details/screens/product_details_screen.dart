import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/product-details";
  final ProductModel productModel;
  const ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.productModel.rating!.length; i++) {
      totalRating += widget.productModel.rating![i].rating;
      if (widget.productModel.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).userModel.id) {
        myRating = widget.productModel.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.productModel.rating!.length;
    }
  }

  void navigateToSearchScreen(String searchQurey) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQurey);
  }

  void addToCart() {
    productDetailsServices.addToCart(
        context: context, productModel: widget.productModel);
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.productModel.id!),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height15,
                horizontal: Dimensions.width10,
              ),
              child: Text(
                widget.productModel.name,
                style: TextStyle(
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                height: Dimensions.height30 * 10,
              ),
              items: widget.productModel.images.map((e) {
                return Builder(
                  builder: (
                    BuildContext context,
                  ) =>
                      Image.network(
                    e,
                    fit: BoxFit.contain,
                    height: Dimensions.height30 * 10,
                  ),
                );
              }).toList(),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.width15 / 2),
              child: RichText(
                text: TextSpan(
                  text: "Deal Price: ",
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "\$${widget.productModel.price}",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width15 / 2,
                right: Dimensions.width15 / 2,
                bottom: Dimensions.height10 / 2,
              ),
              child: Text(widget.productModel.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
              child: CustomButton(text: "Buy Now", onTap: () {}),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10 / 2,
                vertical: Dimensions.height10,
              ),
              child: CustomButton(
                text: "Add to Cart",
                onTap: addToCart,
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width15 / 2,
                right: Dimensions.width15 / 2,
              ),
              child: Text(
                "Rate The Product",
                style: TextStyle(
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding:
                  EdgeInsets.symmetric(horizontal: Dimensions.height10 / 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                  context: context,
                  productModel: widget.productModel,
                  rating: rating,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
