import 'dart:convert';

import 'package:co_safe/providers/user_provider.dart';
import 'package:co_safe/screens/faq_screen.dart';
import 'package:co_safe/screens/home_screen.dart';
import 'package:co_safe/screens/login_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/bluetooth_switch.dart';
import 'package:co_safe/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SlideMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Material(
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              MenuItem(
                icon: Icon(
                  Icons.home,
                  color: kMainAppColor,
                ),
                titleText: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              MenuItem(
                icon: Icon(
                  FontAwesomeIcons.solidQuestionCircle,
                  color: kMainAppColor,
                  size: size.height * 0.033,
                ),
                titleText: 'FAQ',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, FaqScreen.id);
                },
              ),
              MenuItem(
                icon: Icon(
                  Icons.monetization_on,
                  color: kMainAppColor,
                ),
                titleText: 'Donate',
                onTap: () async {
                  Navigator.pop(context);
                  await launch(
                      "https://covid19responsefund.org/en/?gclid=Cj0KCQjwktKFBhCkARIsAJeDT0hlbUlsNWrt5zMPxWJfVK9zxjI1-UkY6w7HnJqSGUmLY1JnfGiRNdkaAkU7EALw_wcB");
                },
              ),
              MenuItem(
                icon: Icon(
                  Icons.warning,
                  color: kMainAppColor,
                ),
                titleText: 'Myth Busters',
                onTap: () async {
                  Navigator.pop(context);
                  await launch(
                      "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters");
                },
              ),
              ListTile(
                leading: Icon(
                  Provider.of<UserProvider>(context, listen: true).optIn
                      ? Icons.bluetooth
                      : Icons.bluetooth_disabled,
                  color: kMainAppColor,
                ),
                title: Text(
                  'Notify',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800),
                ),
                trailing: Bluetooth(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Divider(
                  color: Colors.black87,
                ),
              ),
              MenuItem(
                icon: Icon(
                  Icons.logout,
                  color: kMainAppColor,
                ),
                titleText: 'Sign Out',
                onTap: () async {
                  final msg = jsonEncode({
                    "token":
                        Provider.of<UserProvider>(context, listen: false).token
                  });
                  var response = await http.post(
                      Uri.parse(
                        'http://co-safe.herokuapp.com/user/client/logout',
                      ),
                      headers: <String, String>{
                        'Content-Type': 'application/json'
                      },
                      body: msg);
                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, LoginScreen.id);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
