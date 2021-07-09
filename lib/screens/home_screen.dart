import 'package:co_safe/screens/advices_screen.dart';
import 'package:co_safe/screens/news_screen.dart';
import 'package:co_safe/screens/statistics_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    StatisticsScreen(),
    NewsScreen(),
    AdvicesScreen(),
    NotificationsScreen(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: _screens,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kMainAppColor,
        unselectedItemColor: Colors.black38,
        currentIndex: selectedIndex,
        showUnselectedLabels: true,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.article,
              ),
              label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.wysiwyg,
              ),
              label: 'Advices'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: 'Notifications'),
        ],
      ),
    );
  }
}
