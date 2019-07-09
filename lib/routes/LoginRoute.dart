import 'package:flutter/material.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/ClickableText.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginRoute extends StatelessWidget {
  FocusNode _focus_email = new FocusNode();
  FocusNode _focus_password = new FocusNode();

  TextEditingController _controller_email = new TextEditingController();
  TextEditingController _controller_password = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back),color: JepretColor.PRIMARY_DARKER, onPressed: () {}),
      ),
      body: FormKeyboardActions(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        actions: [
          KeyboardAction(focusNode: _focus_email),
          KeyboardAction(focusNode: _focus_password),
        ],
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                      child: IntrinsicHeight(
                          child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                      child: _renderHeading()
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                      child: _renderTextFields()
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        _renderBottomButtons()
                                      ],
                                    ),
                                  )
                                ],
                              )
                          )
                      )
                  )
              );
            }
        )
      )
    );
  }

  Widget _renderHeading() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeadingText(text: "Masuk"),
          Container(height: 8),
          Text("Masuk ke akun Anda untuk menggunakan Jepret", style: TextStyle(fontSize: 18, color: Colors.black38))
        ],
      ),
    );
  }

  Widget _renderTextFields() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          JepretTextField(
            hint: 'Alamat e-mail',
            icon: Icon(Icons.mail_outline),
            focusNode: _focus_email,
            controller: _controller_email,
          ),
          Container(height: 12),
          JepretTextField(
            hint: 'Kata sandi',
            icon: Icon(Icons.lock),
            isPassword: true,
            focusNode: _focus_password,
            controller: _controller_password,
          ),
          Container(height: 24),
          ClickableText(
            text: "Lupa kata sandi?",
            fontSize: 16,
            onPressed: () {}
          )
        ],
      ),
    );
  }

  Widget _renderBottomButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PrimaryButton(
            text: "Masuk",
            onPressed: () {},
          ),
        ],
      )
    );
  }
}