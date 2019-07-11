import 'package:jepret/model/Authentication.dart';
import 'package:jepret/constants/ApiEndpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static Future<Authentication> login(final String nik, final String password) async {
    String requestBody = json.encode({
      'id_card': nik,
      'password': password
    });

    http.Response response = await http.post(
      ApiEndpoints.LOGIN_URL,
      body: requestBody,
      headers: {
        'Content-Type': 'application/json'
      }
    );

    if(response.statusCode != 200) {
      return Future.value(null);
    }

    final String responseBody = response.body;
    final Map<String, dynamic> map = jsonDecode(responseBody);
    final Map<String, dynamic> data = map['data'];

    final Authentication authentication = Authentication(
      id: data['id'],
      authToken: data['auth_token'],
      email: data['email'],
      name: data['name'],
      nik: data['id_card'],
      phoneNumber: data['phone_number']
    );

    return Future.value(authentication);
  }
}