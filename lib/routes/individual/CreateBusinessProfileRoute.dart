import 'package:flutter/material.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/model/Location.dart';
import 'package:jepret/model/BusinessProfile.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/service/BusinessService.dart';
import 'package:jepret/app.dart';
import 'package:intl/intl.dart';

class CreateBusinessProfileRoute extends StatefulWidget {
  CreateBusinessProfileRouteState createState() => CreateBusinessProfileRouteState();
}

class CreateBusinessProfileRouteState extends State<CreateBusinessProfileRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: JepretColor.PRIMARY_DARKER),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        title: Text("Buat Profil Usaha", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _renderHeading(),
            Divider(height: 1),
            Container(height: 32),
            _renderTextFields()
          ],
        )
      )
    );
  }

  Widget _renderHeading() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Daftarkan usahamu di Jepret",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(height: 4),
                Text(
                  "Daparkan berbagai keuntungan dari aplikasi Jepret dengan membuat Profil Usaha",
                  style: TextStyle(
                    color: Colors.black54
                  )
                )
              ],
            ),
          ),
          Container(width: 8),
          Image(image: AssetImage(Assets.ICON_PROMOTION), width: 80)
        ],
      ),
    );
  }

  Widget _renderTextFields() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                        onPressed: () {
                          _attemptRegister();
                        },
                      )
                  )
                ],
              ),
              Container(height: 32)
            ]
        )
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

  void _attemptRegister() {
    JepretAppState state = JepretApp.of(context);
    final String authToken = state.authentication.authToken;

    final Partner partner = Partner(
      name: _controller_name.text,
      sector: _controller_sector.text,
      imageUrl: _controller_image_url.text,
      founded: DateFormat("yyyy-MM-dd").parse(_controller_founded_date.text),
      location: Location(
        lat: double.parse(_controller_lat.text),
        lon: double.parse(_controller_lon.text),
        streetAddress: _controller_street_address.text,
        province: _controller_province.text,
        municipality: _controller_municipality.text
      )
    );

    BusinessService.register(authToken, partner)
        .then((BusinessProfile businessProfile) {
          return state.saveBusinessProfile(businessProfile);
        })
        .then((_) {
          Navigator.of(context).pop(true);
        })
        .catchError((dynamic e) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.toString())));
        });
  }
}