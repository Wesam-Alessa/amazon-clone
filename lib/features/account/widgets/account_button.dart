import 'package:amazon_clone/constants/dimensions.dart';
import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({Key? key, required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10/2),
        height: Dimensions.height20 * 2,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.radius25 * 2),
            ),
            color: Colors.white),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black12.withOpacity(0.06),
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.all(
              Radius.circular(Dimensions.radius25 * 2),
            ),)
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
