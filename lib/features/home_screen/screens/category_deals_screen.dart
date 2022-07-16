import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home_screen/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<ProductModel>? productsList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProdcts();
  }

  fetchCategoryProdcts() async {
    productsList = null;
    productsList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    productsList = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.height45),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: productsList == null
            ? const Loader()
            : productsList!.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width15,
                            vertical: Dimensions.height10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Keep shopping for ${widget.category}",
                          style: TextStyle(
                            fontSize: Dimensions.font20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30 * 6,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              productsList!.isNotEmpty || productsList != null
                                  ? productsList!.length
                                  : 0,
                          padding: EdgeInsets.only(left: Dimensions.width15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final product = productsList![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProductDetailsScreen.routeName,
                                    arguments: product,);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.screenHeight / 6,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black12, width: 0.5),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(Dimensions.height10),
                                        child: Image.network(product.images[0]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                      left: 0,
                                      top: Dimensions.height10 / 2,
                                      right: Dimensions.width15,
                                    ),
                                    child: Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("product not found!"),
                  ));
  }
}
