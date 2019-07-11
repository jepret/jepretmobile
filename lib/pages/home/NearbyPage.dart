import 'package:flutter/material.dart';
import 'package:jepret/pages/home/NearbyResultPage.dart';

bool _show = true;
List<String> items = <String>[
  '{"name":"Onel\'s Kitchen", "distance":"1", "image": "https://i.imgur.com/ahWbjhP.png"}',
  '{"name":"Gabu\'s Weebs Store", "distance":"1.2", "image": "https://i.imgur.com/ahWbjhP.png"}',
  '{"name":"Feby\'s Breakfast", "distance":"3", "image": "https://i.imgur.com/ahWbjhP.png"}',
  '{"name":"Warung Ko Christzen", "distance":"4", "image": "https://i.imgur.com/ahWbjhP.png"}',
  '{"name":"Didit\'s Solution", "distance":"4.1", "image": "https://i.imgur.com/ahWbjhP.png"}',
  '{"name":"Raigor", "distance":"8.1", "image": "https://i.imgur.com/ahWbjhP.png"}'
];

class NearbyPage extends StatefulWidget {
  NearbyPage() : super();

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    showBottomBar();
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
                  child: NearbyResultPage(items: items)
              )
            ],
          ),
      );
    });
    controller.closed.whenComplete(() {
      showBottomBar();
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

  @override
  Widget build(BuildContext context) {
    int count = items.length;

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
      body: null
    );
  }
}

