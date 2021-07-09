import 'dart:convert';

import 'package:co_safe/models/advice.dart';
import 'package:http/http.dart' as http;

class AdvicesData {
  Future<List<Advice>> getAdvices() async {
    var response =
        await http.get(Uri.parse('http://co-safe.herokuapp.com/advice'));
    var data = jsonDecode(response.body);
    List<Advice> advices = [];
    for (var a in data) {
      Advice advice =
          Advice(title: a['title'], body: a['body'], image: a['image']);
      advices.add(advice);
    }
    return advices;
  }
}
