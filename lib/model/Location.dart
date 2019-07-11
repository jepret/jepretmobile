import 'dart:convert';

class Location {
  String streetAddress;
  String municipality;
  String province;
  double lat;
  double lon;

  Location({
    this.streetAddress,
    this.municipality,
    this.province,
    this.lat,
    this.lon
  });

  Location.fromJson(String str) {
    Map<String, dynamic> map = json.decode(str);
    Location.fromMap(map);
  }

  Location.fromMap(Map<String, dynamic> map) {
    this.streetAddress = map['streetAddress'];
    this.municipality = map['municipality'];
    this.province = map['province'];
    this.lat = map['lat'];
    this.lon = map['lon'];
  }

  Map<String, dynamic> toMap() {
    return {
      'streetAddress': streetAddress,
      'municipality': municipality,
      'province': province,
      'lat': lat,
      'lon': lon
    };
  }

  String serialize() {
    return json.encode(toMap());
  }
}