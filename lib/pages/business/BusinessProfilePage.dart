import 'package:flutter/material.dart';
import 'package:jepret/components/CompletionProgressBar.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/pages/business/BusinessDashboardPage.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class BusinessProfilePage extends StatefulWidget {
  BusinessProfilePageState createState() => BusinessProfilePageState();
}

class BusinessProfilePageState extends State<BusinessProfilePage> {
  FocusNode _focus_name = FocusNode();
  FocusNode _focus_sector = FocusNode();
  FocusNode _focus_founded_date = FocusNode();
  FocusNode _focus_province = FocusNode();
  FocusNode _focus_municipality = FocusNode();
  FocusNode _focus_street_address = FocusNode();

  TextEditingController _controller_name = TextEditingController();
  TextEditingController _controller_sector = TextEditingController();
  TextEditingController _controller_founded_date = TextEditingController();
  TextEditingController _controller_province = TextEditingController();
  TextEditingController _controller_municipality = TextEditingController();
  TextEditingController _controller_street_address = TextEditingController();

  Widget build(BuildContext context) {
    return FormKeyboardActions(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      actions: <KeyboardAction>[
        KeyboardAction(focusNode: _focus_name),
        KeyboardAction(focusNode: _focus_sector),
        KeyboardAction(focusNode: _focus_founded_date),
        KeyboardAction(focusNode: _focus_province),
        KeyboardAction(focusNode: _focus_municipality),
        KeyboardAction(focusNode: _focus_street_address),
      ],
      child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _renderInformationStatusHeader(),
                    Container(height: 32),
                    Text("Profil Usaha", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(height: 16),
                    _renderProfileTextFields(),
                    Container(height: 48),
                    Text("Lokasi Usaha", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(height: 16),
                    _renderLocationTextFields(),
                    Container(height: 32),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: PrimaryButton(
                              text: "Simpan",
                              onPressed: () {},
                            )
                        )
                      ],
                    ),
                    Container(height: 32)
                  ]
              )
          )
      ),
    );
  }

  Widget _renderInformationStatusHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
          child: Material(
            borderRadius: BorderRadius.circular(4),
            color: JepretColor.PRIMARY_DARKER_10,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 52, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  HeadingText(text: "Toko Sinar", color: Colors.black),
                  Text(
                      "Kelengkapan data: 60%",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      )
                  ),
                  Container(height: 16),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: CompletionProgressBar(
                        totalSteps: 5,
                        completedSteps: 3,
                      )
                  ),
                  Container(height: 16),
                  Text(
                    "Lengkapi data untuk dapat mencairkan insentif dan mengajukan peminjaman modal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54
                    ),
                  ),
                  Container(height: 16),
                  Divider(height: 1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Lengkapi data",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: JepretColor.PRIMARY_DARKER
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color.fromARGB(255, 210, 210, 210), width: 3)
          ),
          child: CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage('http://soulofjakarta.com/images-artikel/besar/Tips-Merawat-Kulit-yang-Terkena-Paparan-Sinar-Matahari.jpg'),
          ),
        )
      ],
    );
  }

  Widget _renderProfileTextFields() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            JepretTextField(
              label: "Nama Usaha",
              focusNode: _focus_name,
              controller: _controller_name,
              icon: Icon(Icons.business),
              hasFloatingPlaceholder: true,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Sektor Usaha",
              focusNode: _focus_sector,
              controller: _controller_sector,
              icon: Icon(Icons.business_center),
              hasFloatingPlaceholder: true,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Tanggal Berdiri",
              focusNode: _focus_founded_date,
              controller: _controller_founded_date,
              icon: Icon(Icons.date_range),
              hasFloatingPlaceholder: true,
              keyboardType: TextInputType.datetime,
            )
          ],
        )
    );
  }

  Widget _renderLocationTextFields() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            JepretTextField(
              label: "Provinsi",
              focusNode: _focus_province,
              controller: _controller_province,
              icon: Icon(Icons.location_on),
              hasFloatingPlaceholder: true,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Kabupaten/Kota",
              focusNode: _focus_municipality,
              controller: _controller_municipality,
              icon: Icon(Icons.location_city),
              hasFloatingPlaceholder: true,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Jalan",
              focusNode: _focus_street_address,
              controller: _controller_street_address,
              icon: Icon(Icons.home),
              hasFloatingPlaceholder: true,
              keyboardType: TextInputType.text,
            )
          ],
        )
    );
  }
}