import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  Widget child;
  Function onPressed;

  OutlinedPrimaryButton({@required String text, @required this.onPressed}) {
    this.child = Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }

  OutlinedPrimaryButton.withChild({@required this.child, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child,
      onPressed: onPressed,
      color: JepretColor.PRIMARY,
      textColor: JepretColor.PRIMARY,
      padding: EdgeInsets.all(16),
      borderSide: BorderSide(color: JepretColor.PRIMARY),
      highlightedBorderColor: JepretColor.PRIMARY_DARKER,
    );
  }
}