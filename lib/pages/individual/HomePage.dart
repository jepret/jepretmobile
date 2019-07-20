import 'package:flutter/material.dart';
import 'package:jepret/app.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/HomeShowcaseCard.dart';
import 'package:jepret/components/HomeSectionHeading.dart';
import 'package:jepret/model/Offering.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/model/Location.dart';
import 'package:jepret/routes/individual/RedeemScanBarcodeRoute.dart';
import 'package:jepret/routes/individual/RedeemIncentiveRoute.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loclib;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:jepret/constants/ApiEndpoints.dart';
import 'dart:convert';
import 'package:after_layout/after_layout.dart';
import 'package:latlong/latlong.dart';
import 'package:jepret/pages/individual/Review.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  List<Offering> questItems;
  List<Partner> nearestPartnerItems;
  Location currentLocation;
  int currentVisits = 0;
  loclib.Location loc = new loclib.Location();
  final Distance distance = new Distance();

  @override
  void afterFirstLayout(BuildContext context) {
    debugPrint("firstLayout");

    requestPermission();

    loc.onLocationChanged().listen((Map<String, double> currloc) {
      this.setState(() {
        currentLocation.lat = currloc['latitude'];
        currentLocation.lon = currloc['longitude'];
      });

      loadData();
    });

    getCurrentLocation(loc).then((temp) {
      this.setState(() {
        currentLocation.lat = temp['latitude'];
        currentLocation.lon = temp['longitude'];
      });
    });

    loadData();
  }

  void loadData() {
    getNearbyUMKM(context, currentLocation.lat, currentLocation.lon).then((response) {
      var temp = jsonDecode(response.body);

      List<Offering> offerings = [];
      List<Partner> nearest = [];

      List<dynamic> items = temp['data'];
      print(temp);
      print(items);
      for (int i = 0; i < items.length; i++) {
        offerings.add(
            Offering(
                rewardLevel: items[i]['reward_level'],
                partner: Partner(
                    partnerId: items[i]['id'],
                    name: items[i]['name'],
                    imageUrl: items[i]['photo'],
                    location: Location(
                        lat: items[i]['lat'],
                        lon: items[i]['lng']
                    )
                )
            )
        );

        nearest.add(
            Partner(
                partnerId: items[i]['id'],
                name: items[i]['name'],
                imageUrl: items[i]['photo'],
                location: Location(
                    lat: items[i]['lat'],
                    lon: items[i]['lng']
                )
            )
        );
      }

      this.setState(() {
        questItems = offerings;
        nearestPartnerItems = nearest;
      });
    });
  }

  @override
  void initState() {
    debugPrint("init");

    super.initState();
    this.setState(() {
      this.currentLocation = Location(
        lat: 0,
        lon: 0
      );

      this.questItems = [];
      this.nearestPartnerItems = [];
    });
  }

  Widget build(BuildContext context) {
    debugPrint(nearestPartnerItems.length.toString());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _renderIncentiveHeading(),
          _renderQuestSection(),
          Divider(height: 1),
          _renderNearbySection()
        ],
      )
    );
  }

  Widget _renderIncentiveHeading() {
    JepretAppState state = JepretApp.of(context);

    return Container(
      color: JepretColor.PRIMARY_DARKER,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: <Widget>[
                  Text("Pendapatan Anda", style: TextStyle(color: Colors.white, fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_forward, color: Colors.white)
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                HeadingText(
                    text: NumberFormat.currency(
                      locale: "ID",
                      symbol: "Rp"
                    ).format(state.authentication.balance ?? 0),
                color: Colors.white),
                Spacer(),
                Text("${currentVisits} kunjungan", style: TextStyle(color: Colors.white))
              ],
            )
          ),
          Divider(height: 1, color: Colors.white70),
          Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                    icon: Icon(Icons.shopping_cart),
                    label: Text("Belanjakan"),
                    textColor: Colors.white,
                    onPressed: () {
                      _redeemIncentive();
                    }
                  )
              ),
              Container(height: 48, child: VerticalDivider(color: Colors.white70)),
              Expanded(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.find_in_page),
                    label: Text("Buat Ulasan"),
                    textColor: Colors.white,
                  )
              )
            ],
          ),
        ],
      )
    );
  }

  Widget _renderQuestSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(height: 12),
          HomeSectionHeading(
              title: "Petualangan kamu",
              subtitle: "Kunjungi tempat-tempat ini dan dapatkan poin tambahan!",
              icon: Image(height: 48, image: AssetImage(Assets.ICON_QUEST))
          ),
          Container(height: 8),
          AspectRatio(
            aspectRatio: 16/7,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: questItems.length,
              itemBuilder: (BuildContext context, int index) {
                final Offering _offering = questItems[index];
                final double paddingLeft = (index == 0) ? 8 : 0;
                final double paddingRight = (index == questItems.length-1) ? 8 : 0;

                return Padding(
                  padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingRight, 0),
                  child: HomeShowcaseCard(
                    title: _offering.partner.name,
                    subtitle: "Reward: ${_offering.rewardLevel}",
                    backgroundImage: NetworkImage(_offering.partner.imageUrl),
                    onPressed: () {
                      onUMKMReview(_offering.partner.partnerId);
                    },
                  )
                );
              },
            ),
          ),
          Container(height: 12)
        ],
      )
    );
  }

  Widget _renderNearbySection() {
    return Container(
        child: Column(
          children: <Widget>[
            Container(height: 12),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text("Mitra Terdekat", style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(width: 8),
                  Icon(Icons.arrow_forward, size: 18,)
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 16/7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nearestPartnerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final Partner _partner = nearestPartnerItems[index];
                  final double paddingLeft = (index == 0) ? 8 : 0;
                  final double paddingRight = (index == nearestPartnerItems.length-1) ? 8 : 0;
                  final int distanceKm = distance.as(
                    LengthUnit.Kilometer,
                    LatLng(currentLocation.lat, currentLocation.lon),
                    LatLng(_partner.location.lat, _partner.location.lon)
                  ).round();

                  return Padding(
                      padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingRight, 0),
                      child: HomeShowcaseCard(
                        title: _partner.name,
                        subtitle: "${distanceKm}km",
                        backgroundImage: NetworkImage(_partner.imageUrl),
                        onPressed: () {
                          onUMKMReview(_partner.partnerId);
                        },
                      )
                  );
                },
              ),
            ),
            Container(height: 12)
          ],
        )
    );
  }

  void _redeemIncentive() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => RedeemScanBarcodeRoute())
    ).then((dynamic result) {
      if(result != null) {
        debugPrint("Barcode: ${result}");
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RedeemIncentiveRoute(result))
        );
      }
    });
  }

  requestPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]);
  }

  getCurrentLocation(loclib.Location loc) async {
    return await loc.getLocation();
  }

  getNearbyUMKM(BuildContext context, double lat, double lng) async {
    JepretAppState state = JepretApp.of(context);
    final String authToken = state.authentication.authToken;

    return await http.post(
        ApiEndpoints.GET_NEARBY_UMKM,
        body: json.encode({
          'lat': lat,
          'lng': lng
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken
        }
    );
  }

  void onUMKMReview(int user_id) {
    getUMKMById(user_id).then((Partner partner) {
      print(partner.partnerId);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Review(partner)),
      );
    });
  }

  Future<Partner> getUMKMById(int id) async {
    JepretAppState state = JepretApp.of(context);
    final String authToken = state.authentication.authToken;

    http.Response response = await http.get(
        "${ApiEndpoints.GET_UMKM_BY_ID}${id}",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken
        }
    );

    final String responseBody = response.body;

    debugPrint(responseBody);

    final Map<String, dynamic> map = jsonDecode(responseBody);

    if(response.statusCode != 200) {
      return Future.error(Exception(map['message'].toString()));
    }

    final Map<String, dynamic> data = map['data'];

    final Partner partner = Partner(
        partnerId: data['id'],
        name: data['name'],
        sector: data['sector'],
        imageUrl: data['photo'],
        location: Location(
            lat: data['lat'],
            lon: data['lng'],
            streetAddress: data['address'],
            province: data['province'],
            municipality: data['city']
        )
    );

    return partner;
  }
}