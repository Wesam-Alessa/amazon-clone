// ignore_for_file: unnecessary_const

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final OrderModel orderModel;
  const OrderDetailsScreen({Key? key, required this.orderModel})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String searchQurey) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQurey);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.orderModel.status;
  }

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        orderModel: widget.orderModel,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).userModel;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View order details",
                style: TextStyle(
                    fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Date:      ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.orderModel.orderedAt),
                    )}"),
                    Text("Order ID:          ${widget.orderModel.id}"),
                    Text("Order Total:     \$${widget.orderModel.totalPrice}"),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Text(
                "Purchase Details",
                style: TextStyle(
                    fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Dimensions.height10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.orderModel.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.orderModel.products[i].images[0],
                            height: Dimensions.height30 * 4,
                            width: Dimensions.height30 * 4,
                          ),
                          SizedBox(width: Dimensions.width10 / 2),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.orderModel.products[i].name,
                                  style: TextStyle(
                                      fontSize: Dimensions.font17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Price: \$${widget.orderModel.products[i].price}",
                                  style: TextStyle(
                                      fontSize: Dimensions.font17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Qty: ${widget.orderModel.quantity[i]}",
                                  style: TextStyle(
                                      fontSize: Dimensions.font17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Text(
                "Tracking",
                style: TextStyle(
                    fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == "admin") {
                      return CustomButton(
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),);
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                        title: const Text("Pending"),
                        content:
                            const Text("Your order is yet to be delivered"),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text("Completed"),
                        content: const Text(
                            "Your order has been delivered, you are yet to sign"),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text("Received"),
                        content: const Text(
                            "Your order has been delivered and signed by you"),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text("Delivered"),
                        content: const Text(
                            "Your order has been delivered and signed by you"),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
