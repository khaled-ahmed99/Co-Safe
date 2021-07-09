import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdviceWidget extends StatelessWidget {
  final String title, body;
  AdviceWidget({required this.title, required this.body});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.height * 0.017),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height * 0.05,
            width: size.width,
            decoration: BoxDecoration(
              color: Color(0xFF5CA1AA),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(3),
                topLeft: Radius.circular(3),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: size.height * 0.026),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(3),
                bottomLeft: Radius.circular(3),
              ),
            ),
            child: Text(
              body,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: size.height * 0.025),
            ),
          ),
        ],
      ),
    );
  }
}
