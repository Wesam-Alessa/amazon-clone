import 'package:amazon_clone/constants/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton(
      {Key? key, required this.text, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text,style: TextStyle(color: color == null ? Colors.white : Colors.black),),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, Dimensions.height10 * 5),
          primary: color),
    );
  }
}
