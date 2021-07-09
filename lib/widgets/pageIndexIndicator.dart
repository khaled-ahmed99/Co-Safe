import 'package:flutter/material.dart';

class PageIndexIndicator extends StatelessWidget {
  final bool? isCurrentPage;
  PageIndexIndicator({this.isCurrentPage});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      width: isCurrentPage! ? screenWidth * 0.021 : screenWidth * 0.018,
      height: isCurrentPage! ? screenHeight * 0.014 : screenHeight * 0.012,
      decoration: BoxDecoration(
        color: isCurrentPage! ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
