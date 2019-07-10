import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class JepretTextField extends StatelessWidget {
  String hint;
  Widget icon;
  bool isPassword;
  bool hasFloatingPlaceholder;
  TextEditingController controller;
  FocusNode focusNode;
  TextInputType keyboardType;

  JepretTextField({
    this.hint,
    this.icon,
    this.isPassword: false,
    this.controller,
    this.focusNode,
    this.hasFloatingPlaceholder: false,
    this.keyboardType: TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: icon,
          labelText: hint,
          border: new OutlineInputBorder(),
          hasFloatingPlaceholder: hasFloatingPlaceholder,
      ),
    );
  }
}