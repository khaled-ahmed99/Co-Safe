import 'package:co_safe/utilities/constants.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Widget icon;
  final String titleText;
  final VoidCallback onTap;
  MenuItem({required this.icon, required this.titleText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        titleText,
        style: TextStyle(
            color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.w800),
      ),
      onTap: onTap,
      enableFeedback: true,
      hoverColor: kMainAppColor,
    );
  }
}
