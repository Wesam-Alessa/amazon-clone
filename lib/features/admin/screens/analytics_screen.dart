import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/dimensions.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import 'package:flutter/material.dart';


class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<SalesModel>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningsData = await adminServices.getEarnings(context);
    totalSales = earningsData['totalEarnings'];
    earnings = earningsData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style: TextStyle(
                    fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Dimensions.screenHeight / 3,
                child: CategoryProductsChart(
                  seriesList: [
                    charts.Series(
                      id: "Sales",
                      data: earnings!,
                      domainFn: (SalesModel sales, _) => sales.label,
                      measureFn: (SalesModel sales, _) => sales.earning,
                    )
                  ],
                ),
              ),
            ],
          );
  }
}
