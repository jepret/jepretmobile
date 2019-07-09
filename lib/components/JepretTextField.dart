import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class JepretTextField extends StatelessWidget {
  String hint;
  Widget icon;
  bool isPassword;
  TextEditingController controller;
  FocusNode focusNode;

  JepretTextField({
    this.hint,
    this.icon,
    this.isPassword: false,
    this.controller,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      decoration: InputDecoration(
          prefixIcon: icon,
          border: new OutlineInputBorder(),
          hintText: hint
      ),
    );
  }
}