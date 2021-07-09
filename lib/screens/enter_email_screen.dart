import 'dart:convert';

import 'package:co_safe/widgets/input_text.dart';
import 'package:co_safe/widgets/input_text_with_label.dart';
import 'package:co_safe/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'enter_verification_code.dart';

class EnterEmailScreen extends StatelessWidget {
  static const String id = '/EnterEmailScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    late String email;
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
                    label: 'Enter Email :',
                  ),
                ),
                RoundedButton(
                    text: 'send email',
                    press: () async {
                      if (_globalKey.currentState!.validate()) {
                        _globalKey.currentState!.save();
                        final msg = jsonEncode({
                          "email": email,
                        });
                        var response = await http.post(
                            Uri.parse(
                                'http://co-safe.herokuapp.com/user/client/password/forget'),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: msg);
                        if (response.statusCode == 200) {
                          Navigator.pushNamed(
                              context, EnterVerificationCode.id);
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
