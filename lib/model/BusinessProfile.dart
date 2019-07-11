import 'package:jepret/model/Location.dart';
import 'dart:convert';

class BusinessProfile {
  int balance;
  String partnerId;
  String name;
  String imageUrl;
  String sector;
  DateTime founded;
  Location location;

  BusinessProfile({
    this.balance,
    this.partnerId,
    this.name,
    this.imageUrl,
    this.location,
    this.sector,
    this.founded
  });

  BusinessProfile.fromJson(String str) {
    Map<String, dynamic> map = json.decode(str);

    this.balance = map['balance'];
    this.partnerId = map['partnerId'];
    this.name = map['name'];
    this.imageUrl = map['imageUrl'];
    this.sector = map['sector'];
    this.founded = DateTime.fromMillisecondsSinceEpoch(map['founded']);
    this.location = Location.fromMap(map['location']);
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'partnerId': partnerId,
      'name': name,
      'imageUrl': imageUrl,
      'sector': sector,
      'founded': founded.millisecondsSinceEpoch,
      'location': location.toMap()
    };
  }

  String serialize() {
    return json.encode(toMap());
  }
}