import 'package:co_safe/controller/notification_data.dart';
import 'package:co_safe/models/notifications.dart';
import 'package:co_safe/providers/user_provider.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/notification_widget.dart';
import 'package:co_safe/widgets/silde_menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';

class NotificationsScreen extends StatelessWidget {
  static const String id = '/notifications';
  final NotificationData _notificationData = NotificationData();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SlideMenuDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
              fontSize: size.height * 0.035, fontWeight: FontWeight.w800),
        ),
        backgroundColor: kMainAppColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await _notificationData.getNotifications(
            Provider.of<UserProvider>(context, listen: false).id),
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background_design.png'),
            ),
          ),
          child: FutureBuilder<List<Notifications>>(
            future: _notificationData
                .getNotifications(Provider.of<UserProvider>(context).id),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return LoadingScreen();
              } else {
                return snapshot.data.isEmpty
                    ? Center(
                        child: Text(
                        'No Notifications Found',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ))
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return NotificationWidget(
                              date: snapshot.data[index].date,
                              title: snapshot.data[index].title,
                              body: snapshot.data[index].message);
                        });
              }
            },
          ),
        ),
      ),
    );
  }
}
