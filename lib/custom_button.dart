import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textcolor;
  const CustomButton(
      {super.key, required this.text, this.color, this.textcolor});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          top: height / 84.4,
          right: width / 19.5,
          left: width / 19.5,
          bottom: height / 84.4),
      height: height / 14.06,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(height / 42.2),
          border: Border.all(width: 1, color: Colors.white)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textcolor),
        ),
      ),
    );
  }
}
