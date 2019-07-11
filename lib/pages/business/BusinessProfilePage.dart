import 'package:flutter/material.dart';
import 'package:jepret/components/CompletionProgressBar.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/app.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class BusinessProfilePage extends StatefulWidget {
  BusinessProfilePageState createState() => BusinessProfilePageState();
}

class BusinessProfilePageState extends State<BusinessProfilePage> with AfterLayoutMixin<BusinessProfilePage> {
  int stepsCompleted = 3;
  int stepsExisting = 5;

  FocusNode _focus_name = FocusNode();
  FocusNode _focus_sector = FocusNode();
  FocusNode _focus_founded_date = FocusNode();
  FocusNode _focus_province = FocusNode();
  FocusNode _focus_municipality = FocusNode();
  FocusNode _focus_street_address = FocusNode();
  FocusNode _focus_image_url = FocusNode();
  FocusNode _focus_lat = FocusNode();
  FocusNode _focus_lon = FocusNode();

  TextEditingController _controller_name = TextEditingController();
  TextEditingController _controller_sector = TextEditingController();
  TextEditingController _controller_founded_date = TextEditingController();
  TextEditingController _controller_province = TextEditingController();
  TextEditingController _controller_municipality = TextEditingController();
  TextEditingController _controller_street_address = TextEditingController();
  TextEditingController _controller_image_url = TextEditingController();
  TextEditingController _controller_lat = TextEditingController();
  TextEditingController _controller_lon = TextEditingController();

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

  @override
  void afterFirstLayout(BuildContext context) {
    JepretAppState state = JepretApp.of(context);

    _controller_name.text = state.businessProfile.name;
    _controller_sector.text = state.businessProfile.sector;
    _controller_founded_date.text = DateFormat("yyyy-MM-dd").format(state.businessProfile.founded);
    _controller_image_url.text = state.businessProfile.imageUrl;
    _controller_province.text = state.businessProfile.location.province;
    _controller_municipality.text = state.businessProfile.location.municipality;
    _controller_street_address.text = state.businessProfile.location.streetAddress;
    _controller_lat.text = state.businessProfile.location.lat.toString();
    _controller_lon.text = state.businessProfile.location.lon.toString();
  }

  Widget _renderInformationStatusHeader() {
    JepretAppState state = JepretApp.of(context);

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
                  HeadingText(text: state.businessProfile.name, color: Colors.black),
                  Text(
                      "Kelengkapan data: ${stepsCompleted/stepsExisting * 100}%",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      )
                  ),
                  Container(height: 16),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: CompletionProgressBar(
                        totalSteps: stepsExisting,
                        completedSteps: stepsCompleted,
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
            backgroundImage: NetworkImage(state.businessProfile.imageUrl),
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
              hint: "YYYY-MM-DD",
              keyboardType: TextInputType.datetime,
            ),
            Container(height: 16),
            JepretTextField(
              label: "Tautan Foto Usaha",
              focusNode: _focus_image_url,
              controller: _controller_image_url,
              icon: Icon(Icons.link),
              hasFloatingPlaceholder: true,
              keyboardType: TextInputType.text,
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
            ),
            Container(height: 16),
            JepretTextField(
              label: "Latitude",
              focusNode: _focus_lat,
              controller: _controller_lat,
              icon: Icon(Icons.gps_fixed),
              hasFloatingPlaceholder: true,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            ),
            Container(height: 16),
            JepretTextField(
              label: "Longitude",
              focusNode: _focus_lon,
              controller: _controller_lon,
              icon: Icon(Icons.gps_fixed),
              hasFloatingPlaceholder: true,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            )
          ],
        )
    );
  }
}