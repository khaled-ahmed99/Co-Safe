import 'package:co_safe/controller/advices_data.dart';
import 'package:co_safe/screens/loading_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/advice_widget.dart';
import 'package:co_safe/widgets/silde_menu_drawer.dart';
import 'package:flutter/material.dart';

class AdvicesScreen extends StatelessWidget {
  static const String id = '/advices';
  final AdvicesData _advicesData = AdvicesData();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SlideMenuDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Advices',
          style: TextStyle(
              fontSize: size.height * 0.035, fontWeight: FontWeight.w800),
        ),
        backgroundColor: kMainAppColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await _advicesData.getAdvices(),
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background_design.png'),
            ),
          ),
          child: FutureBuilder(
            future: _advicesData.getAdvices(),
            builder: (context, AsyncSnapshot snapShot) {
              if (snapShot.data == null) {
                return LoadingScreen();
              } else {
                return ListView.builder(
                    itemCount: snapShot.data.length,
                    itemBuilder: (context, index) {
                      return AdviceWidget(
                          title: snapShot.data[index].title,
                          body: snapShot.data[index].body);
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
