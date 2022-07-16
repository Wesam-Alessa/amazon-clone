import 'package:amazon_clone/features/home_screen/widgets/address_box.dart';
import 'package:amazon_clone/features/home_screen/widgets/carousel_image.dart';
import 'package:amazon_clone/features/home_screen/widgets/top_categories.dart';
import 'package:flutter/material.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/global_variables.dart';
import '../../search/screen/search_screen.dart';
import '../widgets/deal_of_day.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const AddressBox(),
            SizedBox(height: Dimensions.height10),
            const TopCategories(),
            SizedBox(height: Dimensions.height10),
            const CarouselImage(),
            const DealOfDay()
          ],
        ),
      ),
    );
  }
}
