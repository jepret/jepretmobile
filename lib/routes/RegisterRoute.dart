import 'package:flutter/material.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/constants/JepretColor.dart';

class RegisterRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back),color: JepretColor.PRIMARY_DARKER, onPressed: () {}),
      ),
      body: SafeArea(
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
              Spacer(),
              _renderBottomButtons()
            ],
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
          JepretTextField(hint: 'Nama lengkap', icon: Icon(Icons.person_outline)),
          Container(height: 12),
          JepretTextField(hint: 'Alamat e-mail', icon: Icon(Icons.mail_outline)),
          Container(height: 12),
          JepretTextField(hint: 'Kata sandi', icon: Icon(Icons.lock), isPassword: true,),
          Container(height: 12),
          JepretTextField(hint: 'Ulangi kata sandi', icon: Icon(Icons.lock_outline), isPassword: true,),
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