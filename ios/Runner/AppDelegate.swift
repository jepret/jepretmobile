import UIKit
import Flutter
import GoogleMaps
//import GooglePlaces

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCCw4vTnVa3UAOf3NcG-S-d6pvKiG8rl98")
//    GMSPlacesClient.provideAPIKey("AIzaSyCCw4vTnVa3UAOf3NcG-S-d6pvKiG8rl98")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
