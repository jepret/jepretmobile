import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class ClickableText extends StatelessWidget {
  String text;
  Color color;
  VoidCallback onPressed;
  double fontSize;

  ClickableText({@required this.text, this.color: JepretColor.PRIMARY_DARKER, this.onPressed, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize
        ),
      )
    );
  }
}