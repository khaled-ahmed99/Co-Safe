import 'package:co_safe/controller/user_data.dart';
import 'package:co_safe/models/user.dart';
import 'package:co_safe/providers/user_provider.dart';
import 'package:co_safe/screens/enter_email_screen.dart';
import 'package:co_safe/screens/loading_screen.dart';
import 'package:co_safe/screens/sign_up_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/background.dart';
import 'package:co_safe/widgets/input_text.dart';
import 'package:co_safe/widgets/password_input_text.dart';
import 'package:co_safe/widgets/rounded_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = '/login';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  final User user = User();
  final UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          progressIndicator: LoadingScreen(),
          inAsyncCall: Provider.of<UserProvider>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: SingleChildScrollView(
              child: Background(
                pathImage: Image.asset(
                  'assets/images/white_wave.png',
                  width: size.width,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.25,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: size.width * 0.01,
                            child: Text(
                              'Co-Safe',
                              style: TextStyle(
                                  fontSize: size.height * .06,
                                  fontFamily: 'Inconsolata',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Image.asset(
                              'assets/images/gp_logo.png',
                              scale: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.01),
                      child: InputText(
                        onSaved: (value) {
                          user.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email';
                          } else if (EmailValidator.validate(value) == false) {
                            return 'please enter a valid email "YourEmail@example.com" ';
                          }
                        },
                        icon: Icon(
                          Icons.person,
                          color: kMainAppColor,
                        ),
                        hintText: 'YourEmail@example.com',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.01),
                      child: PasswordInputText(
                        onSaved: (value) {
                          user.password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          } else if (value.length < 8) {
                            return 'password length must be at least 8 characters';
                          }
                        },
                        onTap: () {
                          Provider.of<UserProvider>(context, listen: false)
                              .showPassword();
                        },
                        obscureText:
                            Provider.of<UserProvider>(context).obscurePassword,
                        hintText: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: kMainAppColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, EnterEmailScreen.id);
                      },
                      child: Text(
                        'Forgot your password ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.13,
                    ),
                    RoundedButton(
                      press: () async {
                        Provider.of<UserProvider>(context, listen: false)
                            .showLoadingIndicator();
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState!.save();
                          try {
                            var response = await userData.loginUser(user);
                            if (response.statusCode == 200) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .getToken(response);
                              Provider.of<UserProvider>(context, listen: false)
                                  .getID(response);
                              Provider.of<UserProvider>(context, listen: false)
                                  .getIsInfected(response);
                              Navigator.pushNamed(context, HomeScreen.id);
                              _globalKey.currentState!.reset();
                            } else {
                              print(response.statusCode);
                            }
                            Provider.of<UserProvider>(context, listen: false)
                                .notShowLoadingIndicator();
                          } catch (e) {
                            print(e);
                          }
                        }
                        Provider.of<UserProvider>(context, listen: false)
                            .notShowLoadingIndicator();
                      },
                      text: 'Login',
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?',
                          style: TextStyle(
                            color: kSlidesTextColor,
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: size.height * 0.022,
                              color: kSlidesTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
