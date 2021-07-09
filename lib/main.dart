import 'package:co_safe/providers/home_provider.dart';
import 'package:co_safe/providers/user_provider.dart';
import 'package:co_safe/screens/advices_screen.dart';
import 'package:co_safe/screens/change_password_screen.dart';
import 'package:co_safe/screens/details_screen.dart';
import 'package:co_safe/screens/enter_email_screen.dart';
import 'package:co_safe/screens/enter_verification_code.dart';
import 'package:co_safe/screens/faq_screen.dart';
import 'package:co_safe/screens/link_details_screen.dart';
import 'package:co_safe/screens/login_screen.dart';
import 'package:co_safe/screens/news_screen.dart';
import 'package:co_safe/screens/notifications_screen.dart';
import 'package:co_safe/screens/onboarding_screen.dart';
import 'package:co_safe/screens/sign_up_screen.dart';
import 'package:co_safe/screens/view_all_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(CoSafe());
}

class CoSafe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<HomeProvider>(
          create: (BuildContext ctx) => HomeProvider(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: kMainAppColor),
          accentColor: kMainAppColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: OnBoardingScreen.id,
        routes: {
          OnBoardingScreen.id: (context) => OnBoardingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          NewsScreen.id: (context) => NewsScreen(),
          AdvicesScreen.id: (context) => AdvicesScreen(),
          NotificationsScreen.id: (context) => NotificationsScreen(),
          FaqScreen.id: (context) => FaqScreen(),
          DetailsScreen.routeName: (BuildContext ct) => DetailsScreen(),
          ViewAll.routeName: (BuildContext ct) => ViewAll(),
          LinkDetailsScreen.routeName: (BuildContext ct) => LinkDetailsScreen(),
          EnterEmailScreen.id: (context) => EnterEmailScreen(),
          EnterVerificationCode.id: (context) => EnterVerificationCode(),
          ChangePasswordScreen.id: (context) => ChangePasswordScreen()
        },
      ),
    );
  }
}
