import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  Widget child;
  Function onPressed;
  bool disabled;
  Color color;
  Color highlightedColor;

  OutlinedPrimaryButton({@required String text, @required this.onPressed, this.disabled: false, this.color: JepretColor.PRIMARY, this.highlightedColor: JepretColor.PRIMARY_DARKER}) {
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
      onPressed: disabled ? null : onPressed,
      color: color,
      textColor: color,
      padding: EdgeInsets.all(16),
      borderSide: BorderSide(color: color),
      highlightedBorderColor: highlightedColor,
    );
  }
}