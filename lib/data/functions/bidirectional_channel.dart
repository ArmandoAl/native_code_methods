// ignore_for_file: avoid_print
import 'package:flutter/services.dart';

const bidirectionalChannel = MethodChannel('bidirectionalChannel');

//En esta función se inicializa el manejador de llamadas de métodos nativos para que escuche las llamadas del código nativo y actualice el estado de la aplicación.
Future<void> initNativeMethodHandler(
  Function(String) setState,
) async {
  bidirectionalChannel.setMethodCallHandler((call) async {
    switch (call.method) {
      case 'nativeToFlutter':
        print('Mensaje del código nativo: ${call.arguments}');
        setState(call.arguments);
        break;
      default:
        print('Method not implemented');
    }
  });
}

//Esta función envía datos al código nativo y actualiza el estado de la aplicación con la respuesta del código nativo.
Future<void> sendDataToNative(
  Function(String) setState,
) async {
  try {
    final response = await bidirectionalChannel
        .invokeMethod('flutterToNative', {'data': 'Hello from Flutter'});
    print('Respuesta del código nativo: $response');
    setState(response);
  } on PlatformException catch (e) {
    print('Error al invocar el método nativo: ${e.message}');
  }
}
