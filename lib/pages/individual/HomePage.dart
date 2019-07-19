import 'package:flutter/material.dart';
import 'package:jepret/app.dart';
import 'package:jepret/constants/Assets.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/components/HeadingText.dart';
import 'package:jepret/components/HomeShowcaseCard.dart';
import 'package:jepret/components/HomeSectionHeading.dart';
import 'package:jepret/model/Offering.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/model/DistancedPartner.dart';
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

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  List<Offering> questItems = [];
  List<DistancedPartner> nearestPartnerItems = [];
  Location currentLocation;
  int currentVisits = 0;
  loclib.Location loc = new loclib.Location();

  @override
  void afterFirstLayout(BuildContext context) {
    requestPermission();

    loc.onLocationChanged().listen((Map<String, double> currloc) {
      this.setState(() {
        currentLocation.lat = currloc['latitude'];
        currentLocation.lon = currloc['longitude'];
      });

      getNearbyUMKM(context, currentLocation.lat, currentLocation.lon).then((response) {
        var temp = jsonDecode(response.body);

        List<Offering> offerings = [];
        List<DistancedPartner> nearest = [];

        List<dynamic> items = temp['data'];
        print(temp);
        print(items);
        for (int i = 0; i < items.length; i++) {
          offerings.add(
              Offering(
                  rewardLevel: items[i]['reward_level'],
                  partner: Partner(
                    partnerId: items[i]['id'].toString(),
                    name: items[i]['name'],
                    imageUrl: items[i]['photo'],
                  )
              )
          );

          nearest.add(
              DistancedPartner(
                  distance: items[i]['distance'],
                  partner: Partner(
                    partnerId: items[i]['id'].toString(),
                    name: items[i]['name'],
                    imageUrl: items[i]['photo'],
                  )
              )
          );
        }

        this.setState(() {
          questItems = offerings;
          nearestPartnerItems = nearest;
        });
      });
    });

    getCurrentLocation(loc).then((temp) {
      this.setState(() {
        currentLocation.lat = temp['latitude'];
        currentLocation.lon = temp['longitude'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.setState(() {
      this.currentLocation = Location(
        streetAddress: "Sopo Del Tower B Lt 8",
        municipality: "Jakarta Selatan",
        province: "DKI Jakarta",
        lat: 0,
        lon: 0
      );
    });
  }

  Widget build(BuildContext context) {
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
                    onPressed: () {},
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
                  final DistancedPartner _partner = nearestPartnerItems[index];
                  final double paddingLeft = (index == 0) ? 8 : 0;
                  final double paddingRight = (index == nearestPartnerItems.length-1) ? 8 : 0;

                  return Padding(
                      padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingRight, 0),
                      child: HomeShowcaseCard(
                        title: _partner.partner.name,
                        subtitle: "${_partner.distance}km",
                        backgroundImage: NetworkImage(_partner.partner.imageUrl),
                        onPressed: () {},
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
}