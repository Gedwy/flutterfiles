import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String inputText;
  final bool underline;
  final bool securePass;
  final TextEditingController mycontroller;

  CustomTextField({
    super.key,
    required this.inputText,
    required this.securePass,
    required this.underline,
    required this.mycontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Color.fromRGBO(225, 95, 27, 0.3), width: 3),
          bottom: underline
              ? BorderSide(color: Colors.grey, width: 1.5)
              : BorderSide(color: Colors.white, width: 0),
        ),
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.length < 10) {
            return "Field Must Be More Than 10";
          }
        },
        controller: mycontroller,
        obscureText: securePass,
        decoration: InputDecoration(
            hintText: inputText,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
