import 'dart:convert';

import 'package:co_safe/providers/user_provider.dart';
import 'package:co_safe/screens/login_screen.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:co_safe/widgets/input_text.dart';
import 'package:co_safe/widgets/input_text_with_label.dart';
import 'package:co_safe/widgets/password_input_text.dart';
import 'package:co_safe/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String id = '/ChangePasswordScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late String email;
    late String password;
    late String confirmPassword;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: InputTextWithLabel(
                    label: 'Enter Email :',
                    child: InputText(
                      onSaved: (value) {
                        email = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.01),
                  child: InputTextWithLabel(
                    label: 'Password :',
                    child: PasswordInputText(
                      onSaved: (value) {
                        password = value!;
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.01),
                  child: InputTextWithLabel(
                    label: 'Confirm Password :',
                    child: PasswordInputText(
                      onSaved: (value) {
                        confirmPassword = value!;
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
                ),
                RoundedButton(
                    text: 'reset password',
                    press: () async {
                      if (_globalKey.currentState!.validate()) {
                        _globalKey.currentState!.save();
                        final msg = jsonEncode({
                          "email": email,
                          "password": password,
                          "confirmPassword": confirmPassword
                        });
                        var response = await http.post(
                            Uri.parse(
                                'http://co-safe.herokuapp.com/user/client/password/reset'),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: msg);
                        if (response.statusCode == 200) {
                          Navigator.pushNamed(context, LoginScreen.id);
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
