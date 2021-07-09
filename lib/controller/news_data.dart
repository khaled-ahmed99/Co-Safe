import 'dart:convert';

import 'package:co_safe/models/news.dart';
import 'package:http/http.dart' as http;

class NewsData {
  Future<List<News>> getNews() async {
    var response =
        await http.get(Uri.parse('http://co-safe.herokuapp.com/news'));
    var data = jsonDecode(response.body);
    List<News> news = [];
    for (var n in data) {
      News newsObject = News(
          title: n['title'],
          body: n['body'],
          image: n['image'],
          url: n['URL'],
          date: n['date']);
      news.add(newsObject);
    }
    return news;
  }
}
