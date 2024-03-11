import 'package:flutter/services.dart';

const dataChannel = MethodChannel('data_channel');

//Esta función invoca el método nativo 'concatenate' y devuelve la respuesta del código nativo.
Future<String> concatenate(String text) async {
  try {
    final String response =
        await dataChannel.invokeMethod('concatenate', {'data': text});
    return response;
  } on PlatformException catch (e) {
    return e.message.toString();
  }
}
