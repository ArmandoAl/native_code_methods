import 'package:flutter/material.dart';

//Este widget muestra un diálogo con la respuesta de la llamada al método nativo.
void showResponseDialog(
    BuildContext context, String flutterResponse, String nativeResponse) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Respuesta del código nativo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Respuesta de Flutter: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                    text: flutterResponse,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Respuesta del código nativo: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                    text: nativeResponse,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
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
}
