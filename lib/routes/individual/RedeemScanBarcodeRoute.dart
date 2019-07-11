import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:jepret/constants/JepretColor.dart';

class RedeemScanBarcodeRoute extends StatefulWidget {
  _RedeemScanBarcodeRouteState createState() => _RedeemScanBarcodeRouteState();
}


class _RedeemScanBarcodeRouteState extends State<RedeemScanBarcodeRoute> with AfterLayoutMixin<RedeemScanBarcodeRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  QRReaderController _qrReaderController;

  _RedeemScanBarcodeRouteState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _qrReaderController?.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    new Future.delayed(const Duration(milliseconds: 300), init);
  }

  void init() async {
    List<CameraDescription> cameras = await availableCameras();
    _qrReaderController = new QRReaderController(cameras[0], ResolutionPreset.high, [CodeFormat.qr], (dynamic value) {
      _onBarcodeScanned(value);
    });

    _qrReaderController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      _qrReaderController.startScanning();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        body: Stack(
            children: <Widget>[
              _getLayout(),
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              _getTopButtons()
            ]
        ),
      )
    );
  }

  Widget _getLayout() {
    if(_qrReaderController == null) {
      return new Container();
    }

    if (!_qrReaderController.value.isInitialized) {
      return new Container();
    }

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Transform.scale(
      scale: _qrReaderController.value.aspectRatio / deviceRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: _qrReaderController.value.aspectRatio,
          child: QRReaderPreview(_qrReaderController),
        ),
      ),
    );
  }

  Widget _getTopButtons() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back),
                  backgroundColor: Colors.white,
                  foregroundColor: JepretColor.PRIMARY_DARKER,
                  mini: true,
                ),
              ],
            ),
            Spacer(),
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(60),
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Icon(Icons.camera_alt, color: Colors.black54, size: 16,),
                      Container(width: 8),
                      Text("Pindai kode QR pada jendela ini", style: TextStyle(color: Colors.black54))
                    ],
                  ),
                )
              ),
            ),
            Container(height: 16)
          ],
        )
      )
    );
  }

  void _onBarcodeScanned(String payload) {
    Navigator.of(context).pop(payload);
  }
}