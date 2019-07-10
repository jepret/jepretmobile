import 'package:flutter/material.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class RegisterRoute extends StatelessWidget {
  FocusNode _focus_name = new FocusNode();
  FocusNode _focus_nik = new FocusNode();
  FocusNode _focus_mobile = new FocusNode();
  FocusNode _focus_password = new FocusNode();
  FocusNode _focus_repassword = new FocusNode();

  TextEditingController _controller_name = new TextEditingController();
  TextEditingController _controller_nik = new TextEditingController();
  TextEditingController _controller_mobile = new TextEditingController();
  TextEditingController _controller_password = new TextEditingController();
  TextEditingController _controller_repassword = new TextEditingController();

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
          KeyboardAction(focusNode: _focus_name),
          KeyboardAction(focusNode: _focus_nik),
          KeyboardAction(focusNode: _focus_mobile),
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
            controller: _controller_name,
            hasFloatingPlaceholder: true
          ),
          Container(height: 16),
          JepretTextField(
            hint: 'Nomor Induk Kependudukan (NIK)',
            icon: Icon(Icons.credit_card),
            keyboardType: TextInputType.number,
            focusNode: _focus_nik,
            controller: _controller_nik,
            hasFloatingPlaceholder: true
          ),
          Container(height: 16),
          JepretTextField(
            hint: 'Nomor Telepon Seluler',
            keyboardType: TextInputType.phone,
            icon: Icon(Icons.phone_iphone),
            focusNode: _focus_mobile,
            controller: _controller_mobile,
            hasFloatingPlaceholder: true
          ),
          Container(height: 16),
          JepretTextField(
            hint: 'Kata sandi',
            icon: Icon(Icons.lock),
            isPassword: true,
            focusNode: _focus_password,
            controller: _controller_password,
            hasFloatingPlaceholder: true
          ),
          Container(height: 16),
          JepretTextField(
            hint: 'Ulangi kata sandi',
            icon: Icon(Icons.lock_outline),
            isPassword: true,
            focusNode: _focus_repassword,
            controller: _controller_repassword,
            hasFloatingPlaceholder: true
          ),
          Container(height: 24),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black45, fontSize: 14),
              children: <TextSpan>[
                TextSpan(text: "Dengan mendaftar, Anda dianggap menyetujui "),
                TextSpan(
                  text: "Syarat dan Ketentuan Penggunaan",
                  style: TextStyle(color: JepretColor.PRIMARY_DARKER)
                ),
                TextSpan(text: " aplikasi Jepret"),
              ]
            ),
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