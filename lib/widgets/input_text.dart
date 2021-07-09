import 'package:co_safe/utilities/constants.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String? hintText;

  final Widget? icon;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  const InputText({this.hintText, this.icon, this.onSaved, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      onSaved: onSaved,
      validator: validator,
      cursorColor: kMainAppColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: icon,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
