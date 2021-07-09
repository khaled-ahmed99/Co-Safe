import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/silde_menu_drawer.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  static const String id = '/FaqScreen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SlideMenuDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'FAQ',
          style: TextStyle(
              fontSize: size.height * 0.035, fontWeight: FontWeight.w800),
        ),
        backgroundColor: kMainAppColor,
      ),
      body: ListView.separated(
        itemCount: kFAQs.length,
        separatorBuilder: (context, index) => Divider(
          height: 3,
          thickness: 1,
          color: kMainAppColor,
        ),
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              kFAQs[index].question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Text(
                kFAQs[index].answer,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
            textColor: Colors.red,
            iconColor: kMainAppColor,
            childrenPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            tilePadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          );
        },
      ),
    );
  }
}
