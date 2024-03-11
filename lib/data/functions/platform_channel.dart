import 'package:flutter/services.dart';

const platform = MethodChannel('platform_channel');

//Esta función invoca el método nativo 'getPlatformVersion' y devuelve la respuesta del código nativo.
Future<String> getPlatformVersion() async {
  try {
    final String response = await platform.invokeMethod('getPlatformVersion');
    return response;
  } on PlatformException catch (e) {
    return e.message.toString();
  }
}
