import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/app.dart';
import 'package:jepret/routes/WelcomeRoute.dart';

class SettingsRoute extends StatefulWidget {
  SettingsRouteState createState() => SettingsRouteState();
}

class SettingsRouteState extends State<SettingsRoute> {
  int currentBalance = 5668456;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: JepretColor.PRIMARY_DARKER),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        title: Text("Pengaturan", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(height: 18),
            _renderButtons()
          ],
        )
      )
    );
  }

  Widget _renderButtons() {
    JepretAppState state = JepretApp.of(context);
    
    return Material(
      elevation: 0,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Divider(height: 1),
          _listMenuItem("Logout", Icon(Icons.exit_to_app), onTap: () {
            state.logout().then((_) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WelcomeRoute()), (Route<dynamic> route) => false);
            });
          }),
          Divider(height: 1)
        ],
      ),
    );
  }

  Widget _listMenuItem(String title, Widget icon, {VoidCallback onTap, Color color}) {
    return ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(color: color)),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}