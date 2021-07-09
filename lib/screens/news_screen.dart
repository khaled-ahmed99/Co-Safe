import 'package:co_safe/controller/news_data.dart';
import 'package:co_safe/screens/loading_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/list_tile_news.dart';
import 'package:co_safe/widgets/silde_menu_drawer.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  static const String id = '/news';
  final NewsData _newsData = NewsData();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SlideMenuDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News',
          style: TextStyle(
              fontSize: size.height * 0.035, fontWeight: FontWeight.w800),
        ),
        backgroundColor: kMainAppColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await _newsData.getNews(),
        child: FutureBuilder(
            future: _newsData.getNews(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return LoadingScreen();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTileNews(
                          image: snapshot.data[index].image,
                          title: snapshot.data[index].title,
                          body: snapshot.data[index].body,
                          date: snapshot.data[index].date,
                          url: snapshot.data[index].url);
                    });
              }
            }),
      ),
    );
  }
}
