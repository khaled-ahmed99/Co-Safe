import 'package:co_safe/providers/home_provider.dart';
import 'package:co_safe/screens/summery.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/silde_menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'loading_screen.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool isLoading = false;
  bool homeDataLoded = false;

  @override
  void initState() {
    super.initState();
    if (homeDataLoded == false) {
      initData();
    }
  }

  void initData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<HomeProvider>(context, listen: false).getData();
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          });
    }
    setState(() {
      isLoading = false;
    });
  }

  int currentPageIndex = 0;
  List<Widget> pages = [HomePage(), Summery()];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SlideMenuDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Co-Safe',
          style: TextStyle(
              fontSize: size.height * 0.035, fontWeight: FontWeight.w800),
        ),
        backgroundColor: kMainAppColor,
      ),
      body: isLoading ? LoadingScreen() : pages[currentPageIndex],
    );
  }
}
