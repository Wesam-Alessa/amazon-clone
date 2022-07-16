import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home_screen/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height30 * 2.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 79,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(context,GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius25 * 2),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]["image"]!,
                      fit: BoxFit.cover,
                      height: Dimensions.height20 * 2.7,
                      width: Dimensions.height20 * 2.7,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10 / 2),
                Text(GlobalVariables.categoryImages[index]["title"]!,
                    style: const TextStyle(fontWeight: FontWeight.w500))
              ],
            ),
          );
        },
      ),
    );
  }
}
