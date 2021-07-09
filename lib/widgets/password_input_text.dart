import 'package:co_safe/providers/user_provider.dart';
import 'package:co_safe/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordInputText extends StatelessWidget {
  final bool obscureText;
  final String? hintText;
  final Widget? icon;
  final VoidCallback? onTap;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  PasswordInputText(
      {this.obscureText = true,
      this.validator,
      this.hintText,
      this.icon,
      this.onSaved,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      cursorColor: kMainAppColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: icon,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            Provider.of<UserProvider>(context).obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: kMainAppColor,
          ),
        ),
        hintText: hintText,
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
