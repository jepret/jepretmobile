import 'package:flutter/material.dart';
import 'package:jepret/routes/HomeRoute.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/ClickableText.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginRoute extends StatefulWidget {
  LoginRouteState createState() => LoginRouteState();
}

class LoginRouteState extends State<LoginRoute> {
  FocusNode _focus_nik = new FocusNode();
  FocusNode _focus_password = new FocusNode();

  TextEditingController _controller_nik = new TextEditingController();
  TextEditingController _controller_password = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back),color: JepretColor.PRIMARY_DARKER, onPressed: () {
          Navigator.of(context).pop();
        }),
      ),
      body: FormKeyboardActions(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        actions: [
          KeyboardAction(focusNode: _focus_nik),
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
            hint: 'Nomor Induk Kependudukan (NIK)',
            icon: Icon(Icons.credit_card),
            focusNode: _focus_nik,
            controller: _controller_nik,
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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => HomeRoute())
              );
            },
          ),
        ],
      )
    );
  }
}