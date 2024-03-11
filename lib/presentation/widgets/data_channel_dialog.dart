// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Esta función muestra un diálogo con la respuesta del código nativo.
void concatenateDialog(BuildContext context, String response) {
  try {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Respuesta del código nativo'),
          content: Text(response),
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
    print("Error al invocar el método nativo: '${e.message}'.");
  }
}
