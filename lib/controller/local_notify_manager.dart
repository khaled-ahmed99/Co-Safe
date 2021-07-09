import 'package:co_safe/screens/notifications_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class LocalNotificationManager {
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  int _id = 0;
  LocalNotificationManager() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }
  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: (payload) async {
        Get.toNamed(NotificationsScreen.id);
      },
    );
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      _id,
      'Co-Safe',
      'there is an infected person around you',
      platformChannelSpecifics,
    );
    _id++;
  }
}
