import 'package:flutter/material.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/OutlinedPrimaryButton.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/constants/Assets.dart';

class WelcomeRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderLogoSection(context),
              Spacer(),
              _renderBottomButtons()
            ],
          )
      )
    );
  }

  Widget _renderLogoSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(height: 48),
          Image(
            width: MediaQuery.of(context).size.width * 2 / 5,
            image: AssetImage(Assets.LOGO)
          ),
          Container(height: 32),
          Text("Jepret", style: TextStyle(fontSize: 48, color: JepretColor.PRIMARY_DARKER, fontWeight: FontWeight.bold))
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
          Container(height: 16),
          OutlinedPrimaryButton(
            text: "Masuk",
            onPressed: () {},
          )
        ],
      )
    );
  }
}