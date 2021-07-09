import 'dart:convert';
import 'package:co_safe/models/notifications.dart';
import 'package:http/http.dart' as http;

class NotificationData {
  Future<List<Notifications>> getNotifications(String id) async {
    var response = await http.get(
        Uri.parse('http://co-safe.herokuapp.com/user/client/notification/$id'));
    var data = jsonDecode(response.body);
    List<Notifications> notificationsList = [];
    for (var Notification in data) {
      Notifications notificationObject = Notifications(
          title: Notification['title'],
          message: Notification['message'],
          date: Notification['date']);
      notificationsList.add(notificationObject);
    }
    return notificationsList;
  }

  Future<http.Response> pushNotification(Notifications notification) async {
    final msg = jsonEncode({
      "title": notification.title,
      "message": notification.message,
      "userId": notification.userId,
      "date": notification.date
    });
    var response = await http.post(
        Uri.parse(
          'http://co-safe.herokuapp.com/user/client/notification',
        ),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: msg);
    return response;
  }
}
