import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String inputText;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onTap;

  const CustomBtn(
      {super.key,
      required this.inputText,
      required this.backgroundColor,
      required this.textColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: backgroundColor),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          inputText,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
