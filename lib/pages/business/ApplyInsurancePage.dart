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

class ApplyInsurancePage extends StatefulWidget {
  ApplyInsurancePageState createState() => ApplyInsurancePageState();
}

class ApplyInsurancePageState extends State<ApplyInsurancePage> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _renderHeading(),
              Divider(height: 1),
              Container(height: 24),
              _renderStats(),
              Container(height: 16),
              _renderOnProgress(),
              Container(height: 32)
            ]
        )
    );
  }

  Widget _renderHeading() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Ajukan Penjaminan",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
          Container(height: 4),
          Text(
            "Ajukan penjaminan modal dengan mudah melalui aplikasi Jepret",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16
            ),
          ),
          Container(height: 32),
          PrimaryButton(
            text: "Ajukan Penjaminan Kredit",
            onPressed: () {

            },
          )
        ],
      )
    );
  }

  Widget _renderStats() {
    JepretAppState state = JepretApp.of(context);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Riwayat Pengajuan Penjaminan",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            )
          ),
          Text(
            "Riwayat penjaminan kredit ${state.businessProfile.name ?? ''}",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16
            ),
          ),
          Container(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 0.5)
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                      children: <Widget>[
                        HeadingText(text: "3"),
                        Text("Diajukan")
                      ],
                    )
                ),
                Container(
                    height: 96,
                    child: VerticalDivider(width: 1)
                ),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        HeadingText(text: "2"),
                        Text("Diproses")
                      ],
                    )
                ),
                Container(
                    height: 96,
                    child: VerticalDivider(width: 1)
                ),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        HeadingText(text: "1"),
                        Text("Diterima")
                      ],
                    )
                ),
                Container(
                    height: 96,
                    child: VerticalDivider(width: 1)
                ),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        HeadingText(text: "0"),
                        Text("Ditolak")
                      ],
                    )
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _renderOnProgress() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
                "Sedang diproses",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                )
            ),
            Container(height: 16),
            _renderListItem("Modal usaha cabang Jakarta", "", 35770100),
            Container(height: 8),
            _renderListItem("Modal usaha cabang Bogor", "", 3200192),
            Container(height: 8),
            _renderListItem("Modal usaha cabang Bandung", "", 99450672)
          ],
        )
    );
  }

  Widget _renderListItem(String title, String date, int nominal) {
    return Material(
      color: JepretColor.PRIMARY_LIGHTER,
      elevation: 1,
      borderRadius: BorderRadius.circular(4),
      child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(NumberFormat.currency(locale: 'ID', symbol: 'Rp').format(nominal))
            ],
          )
      ),
    );
  }
}