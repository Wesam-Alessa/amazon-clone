import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home_screen/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/search_products.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? productsList;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetachSearchedProducts();
  }

  fetachSearchedProducts() async {
    productsList = await searchServices.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String searchQurey) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQurey);
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
      body: productsList == null
          ? const Loader()
          : productsList!.isNotEmpty
              ? Column(
                  children: [
                    const AddressBox(),
                    SizedBox(height: Dimensions.height10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: productsList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.routeName,
                              arguments: productsList![index],
                            ),
                            child: SearchedProduct(
                                productModel: productsList![index]),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    "Product Not Found!",
                  ),
                ),
    );
  }
}
