import 'package:flutter/material.dart';
import 'package:jepret/components/PrimaryButton.dart';
import 'package:jepret/components/OutlinedPrimaryButton.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/routes/RegisterRoute.dart';
import 'package:jepret/routes/LoginRoute.dart';
import 'package:after_layout/after_layout.dart';
import 'package:jepret/app.dart';
import 'package:jepret/routes/WelcomeRoute.dart';
import 'package:jepret/routes/individual/IndividualHomeRoute.dart';

class WelcomeRoute extends StatefulWidget {
  WelcomeRouteState createState() => WelcomeRouteState();
}

class WelcomeRouteState extends State<WelcomeRoute> with AfterLayoutMixin<WelcomeRoute> {
  bool loading = true;

  Widget build(BuildContext context) {
    if(loading) {
      return Container(color: Colors.white);
    } else {
      return Scaffold(
          appBar: null,
          body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _renderLogoSection(context),
                  Spacer(),
                  _renderBottomButtons(context)
                ],
              )
          )
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    JepretAppState state = JepretApp.of(context);
    state.isAuthenticated().then((bool isAuthenticated) {
      if(isAuthenticated) {
        return _launchHomePage();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
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

  Widget _renderBottomButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PrimaryButton(
            text: "Daftar",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => RegisterRoute())
              );
            },
          ),
          Container(height: 16),
          OutlinedPrimaryButton(
            text: "Masuk",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => LoginRoute())
              ).then((dynamic result) {
                if(result == true) {
                  _launchHomePage();
                }
              });
            },
          )
        ],
      )
    );
  }

  Future<dynamic> _launchHomePage() {
    JepretAppState state = JepretApp.of(context);

    return state.keepAuthenticationInState().then((_) {
      return Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => IndividualHomeRoute(),
            transitionsBuilder: (context, anim1, anim2, child) => FadeTransition(opacity: anim1, child: child),
            transitionDuration: Duration(milliseconds: 250),
          )
      );
    });
  }
}