import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class JepretTextField extends StatelessWidget {
  String hint;
  Widget icon;
  bool isPassword;

  JepretTextField({
    this.hint,
    this.icon,
    this.isPassword: false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
          prefixIcon: icon,
          border: new OutlineInputBorder(),
          hintText: hint
      ),
    );
  }
}