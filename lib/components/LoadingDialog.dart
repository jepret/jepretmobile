import 'package:flutter/material.dart';

/**
 * Loading dialog class
 */

class LoadingDialog {
  BuildContext context;
  bool _isVisible = false;

  LoadingDialog(this.context);

  void show() {
    if(!_isVisible) {
      _isVisible = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator()
                  )
              )
          );
        },
      );
    }
  }

  void hide() {
    if(_isVisible) {
      _isVisible = false;
      Navigator.of(context).pop();
    }
  }
}