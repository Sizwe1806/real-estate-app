import Flutter
import UIKit
import PathProvider

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FLTPathProviderPlugin.register(with: registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"))
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
