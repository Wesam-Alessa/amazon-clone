import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descrptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  final _productKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _priceController.dispose();
    _descrptionController.dispose();
    _quantityController.dispose();
  }

  String category = 'Mobiles';
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    "Appliances",
    'Books',
    'Fashion'
  ];

  List<File> images = [];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_productKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: _productNameController.text,
          description: _descrptionController.text,
          price: _priceController.text,
          quantity: _quantityController.text,
          category: category,
          images: images);
    }
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
          title: const Text(
            "Add Product",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _productKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
            child: Column(
              children: [
                SizedBox(height: Dimensions.height15),
                images.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: Dimensions.height20 * 10,
                          //autoPlay: true,
                        ),
                        items: images.map((e) {
                          return Builder(
                            builder: (
                              BuildContext context,
                            ) =>
                                Image.file(
                              e,
                              fit: BoxFit.cover,
                              height: Dimensions.height20 * 10,
                            ),
                          );
                        }).toList(),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(Dimensions.radius10),
                          dashPattern: const [10, 4],
                          child: Container(
                            width: Dimensions.screenWidth,
                            height: Dimensions.height30 * 5,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: Dimensions.iconSize16 * 2.5,
                                ),
                                SizedBox(height: Dimensions.height10),
                                Text(
                                  "Select Product Image",
                                  style: TextStyle(
                                    fontSize: Dimensions.font16,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: Dimensions.height30),
                CustomTextField(
                  controller: _productNameController,
                  hintText: "Product Name",
                ),
                SizedBox(height: Dimensions.height10),
                CustomTextField(
                  controller: _descrptionController,
                  hintText: "Description",
                  maxLines: 7,
                ),
                SizedBox(height: Dimensions.height10),
                CustomTextField(
                  controller: _priceController,
                  hintText: "Price",
                ),
                SizedBox(height: Dimensions.height10),
                CustomTextField(
                  controller: _quantityController,
                  hintText: "Quantity",
                ),
                SizedBox(height: Dimensions.height10),
                SizedBox(
                  width: Dimensions.screenWidth,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        category = val!;
                      });
                    },
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                CustomButton(
                  text: "Sell",
                  onTap: sellProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
