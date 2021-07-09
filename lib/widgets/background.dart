import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Image? pathImage;
  Background({required this.child, this.pathImage});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_design.png'),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: pathImage!,
          ),
          child,
        ],
      ),
    );
  }
}
