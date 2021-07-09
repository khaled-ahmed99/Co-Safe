import 'package:co_safe/utilities/constants.dart';
import 'package:flutter/material.dart';

class InputTextWithLabel extends StatelessWidget {
  final String? label;
  final Widget child;

  InputTextWithLabel({this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: size.height * 0.023,
                fontWeight: FontWeight.w500,
                color: kLightBlack),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
