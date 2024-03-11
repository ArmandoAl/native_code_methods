// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Esta función muestra un diálogo con la respuesta del código nativo.
void getPlatformVersionDialog(BuildContext context, String version) {
  try {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Versión de plataforma'),
          content: Text(version),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  } on PlatformException catch (e) {
    print("Fallo al obtener la versión de la plataforma: '${e.message}'.");
  }
}
