import 'package:co_safe/controller/user_data.dart';
import 'package:co_safe/models/user.dart';
import 'package:co_safe/providers/user_provider.dart';
import 'package:co_safe/screens/login_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/background.dart';
import 'package:co_safe/widgets/input_text.dart';
import 'package:co_safe/widgets/input_text_with_label.dart';
import 'package:co_safe/widgets/password_input_text.dart';
import 'package:co_safe/widgets/rounded_button.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'loading_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = '/sign_up';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final UserData signUpData = UserData();

  final User newUser = User();

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

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
            child: Background(
              pathImage: Image.asset(
                'assets/images/white_wave.png',
                width: size.width,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Get started now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.05,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account ?',
                            style: TextStyle(
                              color: kLightBlack,
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: kLightBlack,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01,
                                  vertical: size.height * 0.01),
                              child: InputTextWithLabel(
                                label: 'First Name :',
                                child: InputText(
                                  onSaved: (value) {
                                    newUser.firstName = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your first name';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01,
                                  vertical: size.height * 0.01),
                              child: InputTextWithLabel(
                                label: 'Last Name :',
                                child: InputText(
                                  onSaved: (value) {
                                    newUser.lastName = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your last name';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.height * 0.01),
                        child: InputTextWithLabel(
                          label: 'Email :',
                          child: InputText(
                            onSaved: (value) {
                              newUser.email = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email';
                              } else if (EmailValidator.validate(value) ==
                                  false) {
                                return 'please enter a valid email "YourEmail@example.com" ';
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.height * 0.01),
                        child: InputTextWithLabel(
                          label: 'Password :',
                          child: PasswordInputText(
                            onSaved: (value) {
                              newUser.password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              } else if (value.length < 8) {
                                return 'password length must be at least 8 characters';
                              }
                            },
                            obscureText: Provider.of<UserProvider>(context)
                                .obscurePassword,
                            onTap: () {
                              Provider.of<UserProvider>(context, listen: false)
                                  .showPassword();
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01,
                              ),
                              child: InputTextWithLabel(
                                label: 'City :',
                                child: InputText(
                                  onSaved: (value) {
                                    newUser.city = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your city';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01,
                              ),
                              child: InputTextWithLabel(
                                label: 'Age :',
                                child: InputText(
                                  onSaved: (value) {
                                    newUser.age = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your age';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.height * 0.01),
                        child: InputTextWithLabel(
                          label: 'Address :',
                          child: InputText(
                            onSaved: (value) {
                              newUser.street = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your address';
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.height * 0.01),
                        child: InputTextWithLabel(
                          label: 'Phone Number :',
                          child: InputText(
                            onSaved: (value) {
                              newUser.phoneNumber = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: size.width * 0.003,
                                  ),
                                ),
                              ),
                              child: CountryListPick(
                                theme: CountryTheme(
                                  alphabetSelectedBackgroundColor:
                                      kMainAppColor,
                                  isShowFlag: true,
                                  isShowTitle: false,
                                  isDownIcon: true,
                                  isShowCode: true,
                                  showEnglishName: true,
                                ),
                                onChanged: (CountryCode? code) {},
                                initialSelection: '+20',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      RoundedButton(
                        text: 'Sign Up',
                        press: () async {
                          Provider.of<UserProvider>(context, listen: false)
                              .showLoadingIndicator();
                          if (_globalKey.currentState!.validate()) {
                            _globalKey.currentState!.save();
                            try {
                              var response =
                                  await signUpData.createUser(newUser);
                              if (response.statusCode == 200) {
                                _globalKey.currentState!.reset();
                                Navigator.pushNamed(context, HomeScreen.id);
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
