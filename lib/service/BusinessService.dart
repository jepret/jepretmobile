import 'package:jepret/model/Location.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/model/BusinessProfile.dart';
import 'package:jepret/constants/ApiEndpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class BusinessService {
  static Future<BusinessProfile> register(String authToken, Partner partner) async {
    String requestBody = json.encode({
      'name': partner.name,
      'sector': partner.sector,
      'photo': partner.imageUrl,
      'founding_date': DateFormat("yyyy-MM-dd").format(partner.founded),
      'lat': partner.location.lat,
      'lng': partner.location.lon,
      'city': partner.location.municipality,
      'province': partner.location.province,
      'address': partner.location.streetAddress
    });

    http.Response response = await http.post(
      ApiEndpoints.CREATE_BUSINESS_PROFILE_URL,
      body: requestBody,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authToken
      }
    );

    final String responseBody = response.body;
    final Map<String, dynamic> map = jsonDecode(responseBody);

    if(response.statusCode != 200) {
      return Future.error(Exception(map['message']));
    }

    final Map<String, dynamic> data = map['data'];
    partner.partnerId = data['unique_id'];

    final BusinessProfile profile = BusinessProfile(
      balance: data['balance'],
      partnerId: data['unique_id'],
      name: data['name'],
      imageUrl: partner.imageUrl,
      sector: partner.sector,
      founded: partner.founded,
      location: partner.location
    );

    return Future.value(profile);
  }

  static Future<BusinessProfile> refreshBusinessProfile(final String authToken) async {
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
      return Future.error(Exception(map['message'].toString()));
    }

    if(map['data']['umkm'] == null) Future.error(Exception("Business profile non-existent"));

    final Map<String, dynamic> data = map['data']['umkm'];

    final BusinessProfile profile = BusinessProfile(
        balance: data['balance'],
        partnerId: data['unique_id'],
        name: data['name'],
        imageUrl: data['photo'],
        sector: data['sector'],
        founded: DateFormat("yyyy-MM-dd").parse(data['founding_date']),
        location: Location(
          streetAddress: data['address'],
          municipality: data['city'],
          province: data['province'],
          lat: data['lat'],
          lon: data['lng']
        )
    );

    return Future.value(profile);
  }
}