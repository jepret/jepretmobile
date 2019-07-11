import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/constants/Preferences.dart';
import 'package:jepret/model/Authentication.dart';
import 'package:jepret/routes/WelcomeRoute.dart';
import 'package:jepret/exceptions/NotAuthenticatedException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JepretApp extends StatefulWidget {
  @override
  JepretAppState createState() => JepretAppState();

  static JepretAppState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer) as _InheritedStateContainer).data;
  }
}

class JepretAppState extends State<JepretApp> with WidgetsBindingObserver {
  final routes = <String, WidgetBuilder>{
    '/': (context) => WelcomeRoute(),
  };

  Authentication _authentication;

  Authentication get authentication {
    return _authentication;
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("Auth token: ${prefs.get(Preferences.AUTH_TOKEN)}");
    return prefs.get(Preferences.AUTH_TOKEN) != null;
  }

  Future<Authentication> getAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get(Preferences.AUTH_TOKEN) == null) {
      return Future.value(null);
    }

    final Authentication authentication = Authentication(
      id: prefs.get(Preferences.ID),
      name: prefs.get(Preferences.NAME),
      nik: prefs.get(Preferences.NIK),
      email: prefs.get(Preferences.EMAIL),
      phoneNumber: prefs.get(Preferences.MOBILE),
      authToken: prefs.get(Preferences.AUTH_TOKEN),
    );

    return authentication;
  }

  Future<void> saveAuthentication(final Authentication authentication) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Preferences.AUTH_TOKEN, authentication.authToken);
    await prefs.setString(Preferences.NAME, authentication.name);
    await prefs.setString(Preferences.EMAIL, authentication.email);
    await prefs.setString(Preferences.MOBILE, authentication.phoneNumber);
    await prefs.setString(Preferences.NIK, authentication.nik);
    await prefs.setInt(Preferences.ID, authentication.id);

    setState(() {
      this._authentication = authentication;
    });
  }

  Future<void> keepAuthenticationInState() async {
    Authentication auth = await getAuthentication();
    if(auth == null) throw NotAuthenticatedException("User not authenticated");

    setState(() {
      this._authentication = auth;
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Preferences.AUTH_TOKEN);
    await prefs.remove(Preferences.NAME);
    await prefs.remove(Preferences.EMAIL);
    await prefs.remove(Preferences.MOBILE);
    await prefs.remove(Preferences.NIK);
    await prefs.remove(Preferences.ID);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
        data: this,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Jepret',
          theme: ThemeData(
              primaryColor: JepretColor.PRIMARY,
              primaryColorDark: JepretColor.PRIMARY_DARKER,
              backgroundColor: JepretColor.APP_BACKGROUND_LIGHT,
              fontFamily: "NunitoSans"
          ),
          home: WelcomeRoute(),
        )
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  // Data is your entire state. In our case just 'User'
  final JepretAppState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
