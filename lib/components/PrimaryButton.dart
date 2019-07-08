import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class PrimaryButton extends StatelessWidget {
  Widget child;
  Function onPressed;

  PrimaryButton({@required String text, @required this.onPressed}) {
    this.child = Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }

  PrimaryButton.withChild({@required this.child, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
      color: JepretColor.PRIMARY,
      textColor: Colors.white,
      padding: EdgeInsets.all(16),
    );
  }
}