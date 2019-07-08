import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class HeadingText extends StatelessWidget {
  String text;
  Color color;

  HeadingText({@required this.text, this.color: JepretColor.PRIMARY_DARKER});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: color,
        fontWeight: FontWeight.bold
      ),
    );
  }
}