import 'package:jepret/model/Location.dart';

class Partner {
  int partnerId;
  String name;
  String imageUrl;
  String sector;
  DateTime founded;
  Location location;

  Partner({
    this.partnerId,
    this.name,
    this.imageUrl,
    this.location,
    this.sector,
    this.founded
  });
}