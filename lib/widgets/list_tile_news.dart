import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTileNews extends StatelessWidget {
  final String image, title, body, date, url;
  String smallSentence(String bigSentence) {
    if (bigSentence.length > 10) {
      return bigSentence.substring(0, 10);
    } else {
      return bigSentence;
    }
  }

  ListTileNews(
      {required this.image,
      required this.title,
      required this.body,
      required this.date,
      required this.url});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        child: Column(
          children: [
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
              ),
              leading: Image.network(image),
              title: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.red,
                      size: size.height * 0.018,
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Text(
                      smallSentence(date),
                      style: TextStyle(
                          color: Colors.black87, fontSize: size.height * 0.018),
                    ),
                  ],
                ),
              ),
              onTap: () async => await launch(url),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Divider(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
