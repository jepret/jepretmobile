import 'package:flutter/material.dart';
import 'package:jepret/pages/individual/NearbyResultPage.dart';
import 'package:jepret/model/Partner.dart';
import 'package:jepret/model/Location.dart' as JepretModelLocation;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:permission_handler/permission_enums.dart';
import 'package:http/http.dart' as http;
import 'package:jepret/constants/ApiEndpoints.dart';
import 'dart:convert';
import 'package:jepret/app.dart';
import 'package:jepret/pages/individual/Review.dart';

bool _show = true;
List<String> items = <String>[
  '{"name":"Onel\'s Kitchen", "distance":"1", "image": "https://i.imgur.com/ahWbjhP.png", "rewardLevel": 3}',
  '{"name":"Gabu\'s Weebs Store", "distance":"1.2", "image": "https://i.imgur.com/ahWbjhP.png", "rewardLevel": 4}',
  '{"name":"Feby\'s Breakfast", "distance":"3", "image": "https://i.imgur.com/ahWbjhP.png", "rewardLevel": 5}',
  '{"name":"Warung Ko Christzen", "distance":"4", "image": "https://i.imgur.com/ahWbjhP.png", "rewardLevel": 2}',
  '{"name":"Didit\'s Solution", "distance":"4.1", "image": "https://i.imgur.com/ahWbjhP.png", "rewardLevel": 1}',
  '{"name":"Raigor", "distance":"8.1", "image": "https://i.imgur.com/ahWbjhP.png", "rewardLevel": 0}'
];
List<dynamic> itemss = [];

class NearbyPage extends StatefulWidget {
  NearbyPage() : super();

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<Marker> _markers = {};
  GoogleMapController  mapController;
  var loc = new Location();
  double lat, lng;
//  var _center = new LatLng(-6.1327059, 106.8098622);
  var _center = new LatLng(-3.1327059, 103.8098622);

  void _onMapCreated(GoogleMapController controller) {
//    _controller.complete(controller);
    mapController = controller;
    loc.onLocationChanged().listen((Map<String, double> currentLocation) {
      _center = LatLng(currentLocation['latitude'], currentLocation['longitude']);
    });
    getCurrentLocation(loc).then((temp) {
      _center = new LatLng(temp['latitude'], temp['longitude']);
      mapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(target: _center, zoom: 18.0)));
      generateUserMarker();
      getNearbyUMKM(context, temp['latitude'], temp['longitude']).then((response) {
        var temp = jsonDecode(response.body);
        itemss = temp['data'];
        print(temp);
        print(itemss);
        for (int i = 0; i < itemss.length; i++)
          generateUmkmMarker(context, itemss[i]);
//        mapController.
      });
      this.setState(() {
        this.lat = temp['latitude'];
        this.lng = temp['longitude'];
      });
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
    showBottomBar();

    this.setState(() {
      this.lat = 0;
      this.lng = 0;
    });

    getCurrentLocation(loc).then((temp) {
      _center = new LatLng(temp['latitude'], temp['longitude']);
      generateUserMarker();
      getNearbyUMKM(context, temp['latitude'], temp['longitude']).then((response) {
        var temp = jsonDecode(response.body);
        itemss = temp['data'];
        for (int i = 0; i < itemss.length; i++)
          generateUmkmMarker(context, itemss[i]);
      });
      this.setState(() {
        this.lat = temp['latitude'];
        this.lng = temp['longitude'];
      });
    });

    generateUserMarker();
  }

  PersistentBottomSheetController controller;

  openPersistentBottomController(BuildContext context){
    controller = _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return Container(
        padding: EdgeInsets.fromLTRB(0.0, 15.00, 0.00, 0.00),
        color: Colors.white,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width,
        ),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                hideBottomSheet();
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(width: 15.00),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                  const SizedBox(width: 15.00),
                  Text("Sembunyikan"),
                ],
              ),
            ),
            const SizedBox(height: 15.00),
            Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.width * 0.50,
                  maxWidth: MediaQuery.of(context).size.width * 1.00,
                ),
                child: NearbyResultPage(items: itemss)
            )
          ],
        ),
      );
    });
    controller.closed.whenComplete(() {
      showBottomBar();
    });
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

  void hideBottomSheet() {
    controller.close();
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  Future<void> generateUserMarker() async {
    LatLng _lastMapPosition = _center;

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId("User"),
      position: _lastMapPosition,
      infoWindow: InfoWindow(
        title: 'Your current position',
        onTap: () {print('User');},
      ),
      icon: BitmapDescriptor.defaultMarker,
//      icon: BitmapDescriptor.fromAsset('assets/img/dollar.png'),
    ));
  }

  Future<void> generateUmkmMarker(BuildContext context , dynamic detail) async {
    LatLng _position = new LatLng(detail['lat'], detail['lng']);
    print(detail['lat']);
    print(detail['lng']);

    String dollarAsset;
    if (detail['reward_level'] == 1) {
      dollarAsset = 'assets/img/dollar.png';
    } else if (detail['reward_level'] == 2) {
      dollarAsset = 'assets/img/dollars.png';
    } else if (detail['reward_level'] == 3) {
      dollarAsset = 'assets/img/dollarss.png';
    } else {
      dollarAsset = 'assets/img/nodollar.png';
    }

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(detail['name']),
      position: _position,
      infoWindow: InfoWindow(
        title: detail['name'],
        snippet: detail['address'],
        onTap: () {
          onUMKMReview(detail['id']);
        },
      ),
//      icon: BitmapDescriptor.defaultMarker,
      icon: BitmapDescriptor.fromAsset(dollarAsset),
    ));
  }

  @override
  Widget build(BuildContext context) {
    int count = itemss.length;
    requestPermission();
    print(_markers);

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: _show ? new GestureDetector(
        onTap: () {
          hideBottomBar();
          openPersistentBottomController(context);
        },
        child: BottomAppBar(
            child: new Container(
              padding: EdgeInsets.all(15.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_up),
                  const SizedBox(width: 10),
                  Text("Tampilkan $count mitra sekitar"),
                ],
              ),
            )
        ),
      ) : null,
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 18.0,
        ),
        markers: _markers,
      ),
    );
  }

  requestPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]);
  }

  getCurrentLocation(loc) async {
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

  Future<Partner> getUMKMById(int id) async {
    JepretAppState state = JepretApp.of(context);
    final String authToken = state.authentication.authToken;

    http.Response response = await http.get(
        "${ApiEndpoints.GET_UMKM_BY_ID}/${id}",
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

    final Map<String, dynamic> data = map['data'];

    final Partner partner = Partner(
        partnerId: data['id'],
        name: data['name'],
        sector: data['sector'],
        imageUrl: data['photo'],
        location: JepretModelLocation.Location(
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