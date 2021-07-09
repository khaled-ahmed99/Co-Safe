import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String _url;

  NetworkHelper(this._url);

  Future getWorldWideData() async {
    http.Response response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    print(response.statusCode);
  }

  Future getCountryData() async {
    http.Response response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    print(response.statusCode);
  }
}
