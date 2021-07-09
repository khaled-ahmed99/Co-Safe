import 'package:co_safe/utilities/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kMainAppColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: color,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              spreadRadius: 1.0,
              offset: Offset(1, 3),
              color: Colors.grey.withOpacity(0.5),
            ),
          ]),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: TextButton(
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 15.0, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
