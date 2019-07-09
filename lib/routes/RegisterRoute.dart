import 'package:flutter/material.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class RegisterRoute extends StatelessWidget {
  FocusNode _focus_name = new FocusNode();
  FocusNode _focus_email = new FocusNode();
  FocusNode _focus_password = new FocusNode();
  FocusNode _focus_repassword = new FocusNode();

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
          KeyboardAction(focusNode: _focus_name),
          KeyboardAction(focusNode: _focus_email),
          KeyboardAction(focusNode: _focus_password),
          KeyboardAction(focusNode: _focus_repassword)
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
          HeadingText(text: "Buat akun baru"),
          Container(height: 8),
          Text("Daftarkan diri Anda untuk menggunakan Jepret", style: TextStyle(fontSize: 18, color: Colors.black38))
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
            hint: 'Nama lengkap',
            icon: Icon(Icons.person_outline),
            focusNode: _focus_name,
          ),
          Container(height: 12),
          JepretTextField(
            hint: 'Alamat e-mail',
            icon: Icon(Icons.mail_outline),
            focusNode: _focus_email,
          ),
          Container(height: 12),
          JepretTextField(
            hint: 'Kata sandi',
            icon: Icon(Icons.lock),
            isPassword: true,
            focusNode: _focus_password,
          ),
          Container(height: 12),
          JepretTextField(
            hint: 'Ulangi kata sandi',
            icon: Icon(Icons.lock_outline),
            isPassword: true,
            focusNode: _focus_repassword,
          ),
          Container(height: 24),
          Text(
            "Dengan mendaftar, Anda dianggap menyetujui Syarat dan Ketentuan Penggunaan aplikasi Jepret",
            style: TextStyle(color: Colors.black45, fontSize: 14),
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
            text: "Daftar",
            onPressed: () {},
          ),
        ],
      )
    );
  }
}