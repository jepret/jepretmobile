import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/OutlinedPrimaryButton.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class IndividualProfilePage extends StatefulWidget {
  IndividualProfilePageState createState() => IndividualProfilePageState();
}

class IndividualProfilePageState extends State<IndividualProfilePage> {
  FocusNode _focus_name = new FocusNode();
  FocusNode _focus_email = new FocusNode();
  FocusNode _focus_mobile = new FocusNode();
  FocusNode _focus_nik = new FocusNode();

  TextEditingController _controller_name = new TextEditingController();
  TextEditingController _controller_email = new TextEditingController();
  TextEditingController _controller_mobile = new TextEditingController();
  TextEditingController _controller_nik = new TextEditingController();

  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _renderProfileHeading(),
            Expanded(
              child: FormKeyboardActions(
                  keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                  actions: [
                    KeyboardAction(focusNode: _focus_name),
                    KeyboardAction(focusNode: _focus_email),
                    KeyboardAction(focusNode: _focus_mobile),
                    KeyboardAction(focusNode: _focus_nik),
                  ],
                  child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints viewportConstraints) {
                        return SingleChildScrollView(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                                child: IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        _renderBusinessProfileRegistrationOffer(),
                                        _renderTextFields(),
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
                        );
                      }
                  )
              )
            )
          ],
        )
    );
  }

  Widget _renderProfileHeading() {
    return Container(
        color: JepretColor.PRIMARY_DARKER,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Agung Boba",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  "3271061010010001",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w200
                  ),
                ),
              ],
            )
        )
    );
  }

  Widget _renderTextFields() {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: <Widget>[
            JepretTextField(
              label: "Nama Lengkap",
              focusNode: _focus_name,
              controller: _controller_name,
              icon: Icon(Icons.person_outline),
              hasFloatingPlaceholder: true,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Alamat E-mail",
              focusNode: _focus_email,
              controller: _controller_email,
              icon: Icon(Icons.mail_outline),
              keyboardType: TextInputType.emailAddress,
              hasFloatingPlaceholder: true,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Nomor Telepon Seluler",
              focusNode: _focus_mobile,
              controller: _controller_mobile,
              icon: Icon(Icons.phone),
              hasFloatingPlaceholder: true,
              keyboardType: TextInputType.phone,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Nomor Induk Kependudukan (NIK)",
              focusNode: _focus_nik,
              controller: _controller_nik,
              icon: Icon(Icons.account_balance),
              hasFloatingPlaceholder: true,
              keyboardType: TextInputType.number,
            )
          ],
        )
    );
  }

  Widget _renderBottomButtons() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlinedPrimaryButton(
              text: "Simpan",
              onPressed: () {},
            )
          ],
        )
    );
  }

  Widget _renderBusinessProfileRegistrationOffer() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(4),
        child: Column(
          children: <Widget>[
            Container(
              color: JepretColor.PRIMARY_DARKER_10,
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Image(image: AssetImage(Assets.ICON_SURPRISE_BOX), width: 72,),
                  Container(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Buat profil usaha!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("Dapatkan banyak kemudahan dengan profil usaha", style: TextStyle(fontSize: 15, color: Colors.black54)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1, color: Colors.black26),
            Container(
              color: JepretColor.PRIMARY_DARKER_10,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: FlatButton(
                        child: Text(
                          "Buat profil usaha",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: JepretColor.PRIMARY_DARKER
                          )
                        ),
                        onPressed: () {},
                      )
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }
}