import 'package:flutter/material.dart';
import 'package:jepret/exceptions/LoginFailedException.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/ClickableText.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/service/UserService.dart';
import 'package:jepret/model/Authentication.dart';
import 'package:jepret/app.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginRoute extends StatefulWidget {
  LoginRouteState createState() => LoginRouteState();
}

class LoginRouteState extends State<LoginRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode _focus_nik = new FocusNode();
  FocusNode _focus_password = new FocusNode();

  TextEditingController _controller_nik = new TextEditingController();
  TextEditingController _controller_password = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            label: 'Nomor Induk Kependudukan (NIK)',
            icon: Icon(Icons.credit_card),
            focusNode: _focus_nik,
            controller: _controller_nik,
          ),
          Container(height: 12),
          JepretTextField(
            label: 'Kata sandi',
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
              _attemptLogin();
            },
          ),
        ],
      )
    );
  }

  void _attemptLogin() {
    JepretAppState state = JepretApp.of(context);

    UserService.login(_controller_nik.value.text, _controller_password.value.text)
        .then((Authentication authentication) {
          if(authentication == null) {
            throw new LoginFailedException("Invalid NIK and/or password");
          }

          return state.saveAuthentication(authentication);
        })
        .then((_) {
          Navigator.of(context).pop(true);
        })
        .catchError((_) {
          // TODO show error
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("NIK dan/atau kata sandi salah")));
        });
  }
}