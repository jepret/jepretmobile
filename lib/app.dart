import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/constants/Preferences.dart';
import 'package:jepret/model/Authentication.dart';
import 'package:jepret/model/BusinessProfile.dart';
import 'package:jepret/routes/WelcomeRoute.dart';
import 'package:jepret/exceptions/NotAuthenticatedException.dart';
import 'package:jepret/service/UserService.dart';
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
  BusinessProfile _businessProfile;

  Authentication get authentication {
    return _authentication;
  }

  BusinessProfile get businessProfile {
    return _businessProfile;
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
        id: prefs.getInt(Preferences.ID),
        name: prefs.getString(Preferences.NAME),
        nik: prefs.getString(Preferences.NIK),
        email: prefs.getString(Preferences.EMAIL),
        phoneNumber: prefs.getString(Preferences.MOBILE),
        authToken: prefs.getString(Preferences.AUTH_TOKEN),
        hasBusinessProfile: prefs.getBool(Preferences.HAS_BUSINESS_PROFILE),
        balance: prefs.getInt(Preferences.BALANCE)
    );

    return authentication;
  }

  Future<BusinessProfile> getBusinessProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get(Preferences.BUSINESS_PROFILE_JSON) == null) {
      return Future.value(null);
    }

    final BusinessProfile profile = BusinessProfile.fromJson(prefs.get(Preferences.BUSINESS_PROFILE_JSON));

    return profile;
  }

  Future<void> saveAuthentication(final Authentication authentication) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Preferences.AUTH_TOKEN, authentication.authToken);
    await prefs.setString(Preferences.NAME, authentication.name);
    await prefs.setString(Preferences.EMAIL, authentication.email);
    await prefs.setString(Preferences.MOBILE, authentication.phoneNumber);
    await prefs.setString(Preferences.NIK, authentication.nik);
    await prefs.setInt(Preferences.ID, authentication.id);
    await prefs.setBool(Preferences.HAS_BUSINESS_PROFILE, authentication.hasBusinessProfile);
    await prefs.setInt(Preferences.BALANCE, authentication.balance);

    setState(() {
      this._authentication = authentication;
    });
  }

  Future<void> saveBusinessProfile(final BusinessProfile businessProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Preferences.BUSINESS_PROFILE_JSON, businessProfile.serialize());
    await prefs.setBool(Preferences.HAS_BUSINESS_PROFILE, true);

    keepAuthenticationInState();
  }

  Future<void> keepAuthenticationInState() async {
    Authentication auth = await getAuthentication();
    if(auth == null) throw NotAuthenticatedException("User not authenticated");

    BusinessProfile businessProfile = await getBusinessProfile();

    setState(() {
      this._authentication = auth;
      this._businessProfile = businessProfile;
    });
  }

  Future<void> refreshAuthentication() async {
    Authentication auth = await getAuthentication();
    if(auth == null) throw NotAuthenticatedException("User not authenticated");

    Authentication authentication = await UserService.refreshAuthentication(auth.authToken);
    saveAuthentication(authentication);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Preferences.AUTH_TOKEN);
    await prefs.remove(Preferences.NAME);
    await prefs.remove(Preferences.EMAIL);
    await prefs.remove(Preferences.MOBILE);
    await prefs.remove(Preferences.NIK);
    await prefs.remove(Preferences.ID);
    await prefs.remove(Preferences.HAS_BUSINESS_PROFILE);
    await prefs.remove(Preferences.BUSINESS_PROFILE_JSON);
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
