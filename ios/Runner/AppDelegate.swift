import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var platformChannel: FlutterMethodChannel?
  private var dataChannel: FlutterMethodChannel?
  private var bidirectionalChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    
    platformChannel = FlutterMethodChannel(name: "platform_channel", binaryMessenger: controller.binaryMessenger)
    dataChannel = FlutterMethodChannel(name: "data_channel", binaryMessenger: controller.binaryMessenger)
    bidirectionalChannel = FlutterMethodChannel(name: "bidirectionalChannel", binaryMessenger: controller.binaryMessenger)

    platformChannel?.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if ("getPlatformVersion" == call.method) {
            result("iOS " + UIDevice.current.systemVersion)
        } else {
            result(FlutterMethodNotImplemented)
        }
    })

    dataChannel?.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if ("concatenate" == call.method) {
            let data = call.arguments as! String
            result(data + " -Native")
        } else {
            result(FlutterMethodNotImplemented)
        }
    })

    bidirectionalChannel?.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if ("flutterToNative" == call.method) {
            let data = call.arguments as! String
            result(data + " recibido desde nativo")
          
                self.bidirectionalChannel?.invokeMethod("nativeToFlutter", arguments: "Hello from native")
            
        } else {
            result(FlutterMethodNotImplemented)
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
