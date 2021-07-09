import 'dart:convert';

import 'package:co_safe/screens/change_password_screen.dart';
import 'package:co_safe/widgets/input_text.dart';
import 'package:co_safe/widgets/input_text_with_label.dart';
import 'package:co_safe/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EnterVerificationCode extends StatelessWidget {
  static const String id = '/EnterVerificationCode';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    late String email;
    late String code;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Container(
          child: Center(
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: InputTextWithLabel(
                    label: 'Enter Verification Code :',
                    child: InputText(
                      onSaved: (value) {
                        code = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter verification code';
                        }
                      },
                    ),
                  ),
                ),
                RoundedButton(
                    text: 'send verification code',
                    press: () async {
                      if (_globalKey.currentState!.validate()) {
                        _globalKey.currentState!.save();
                        final msg = jsonEncode(
                            {"email": email, "verificationCode": code});
                        var response = await http.post(
                            Uri.parse(
                                'http://co-safe.herokuapp.com/user/client/password/code/verification'),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: msg);
                        print(response.statusCode);
                        if (response.statusCode == 200) {
                          Navigator.pushNamed(context, ChangePasswordScreen.id);
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
