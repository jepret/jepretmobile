import 'package:jepret/model/Authentication.dart';
import 'package:jepret/model/Registration.dart';
import 'package:jepret/model/Transaction.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/model/Location.dart';
import 'package:jepret/constants/ApiEndpoints.dart';
import 'package:jepret/exceptions/UserRegistrationException.dart';
import 'package:jepret/exceptions/LoginFailedException.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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

    final String responseBody = response.body;
    final Map<String, dynamic> map = jsonDecode(responseBody);

    if(response.statusCode != 200) {
      return Future.error(LoginFailedException(map['message']));
    }

    final Map<String, dynamic> data = map['data'];

    final Authentication authentication = Authentication(
      id: data['id'],
      authToken: data['auth_token'],
      email: data['email'],
      name: data['name'],
      nik: data['id_card'],
      phoneNumber: data['phone_number'],
      hasBusinessProfile: data['has_umkm'],
      balance: data['balance']
    );

    return Future.value(authentication);
  }

  static Future<Authentication> register(final Registration registration) async {
    String requestBody = json.encode({
      'name': registration.name,
      'phone_number': registration.phoneNumber,
      'id_card': registration.nik,
      'password': registration.password
    });

    http.Response response = await http.post(
        ApiEndpoints.REGISTER_URL,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json'
        }
    );

    final String responseBody = response.body;
    final Map<String, dynamic> map = jsonDecode(responseBody);

    if(response.statusCode != 200) {
      return Future.error(UserRegistrationException(map['message'].toString()));
    }

    final Map<String, dynamic> data = map['data'];

    final Authentication authentication = Authentication(
        id: data['id'],
        authToken: data['auth_token'],
        email: data['email'],
        name: data['name'],
        nik: data['id_card'],
        phoneNumber: data['phone_number'],
        hasBusinessProfile: false,
        balance: data['balance']
    );

    return Future.value(authentication);
  }

  static Future<Authentication> refreshAuthentication(final String authToken) async {
    http.Response response = await http.get(
        ApiEndpoints.PROFILE_URL,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken
        }
    );

    final String responseBody = response.body;
    final Map<String, dynamic> map = jsonDecode(responseBody);

    if(response.statusCode != 200) {
      return Future.error(UserRegistrationException(map['message'].toString()));
    }

    final Map<String, dynamic> data = map['data'];

    final Authentication authentication = Authentication(
        id: data['id'],
        authToken: authToken,
        email: data['email'],
        name: data['name'],
        nik: data['id_card'],
        phoneNumber: data['phone_number'],
        hasBusinessProfile: data['has_umkm'],
        balance: data['balance']
    );

    return Future.value(authentication);
  }

  static Future<Transaction> redeemIncentive(String authToken, String merchantId, int nominal) async {
    String requestBody = json.encode({
      'umkm_uid': merchantId,
      'amount': nominal
    });

    http.Response response = await http.post(
        ApiEndpoints.CREATE_TRANSACTION_URL,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken
        }
    );

    final String responseBody = response.body;
    final Map<String, dynamic> map = jsonDecode(responseBody);

    if(response.statusCode != 200) {
      return Future.error(UserRegistrationException(map['message'].toString()));
    }

    final Map<String, dynamic> data = map['data'];
    final Map<String, dynamic> partner = data['receiver'];

    final Transaction transaction = Transaction(
        amount: data['amount'],
        id: data['id'],
        recipient: Partner(
            name: partner['name'],
            sector: partner['sector'],
            imageUrl: partner['photo'],
            location: Location(
                lat: partner['lat'],
                lon: partner['lng'],
                streetAddress: partner['address'],
                province: partner['province'],
                municipality: partner['city']
            )
        )
    );

    return Future.value(transaction);
  }
}