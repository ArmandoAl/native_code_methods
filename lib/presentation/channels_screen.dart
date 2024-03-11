// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../data/functions/bidirectional_channel.dart';
import '../data/functions/data_channel.dart';
import '../data/functions/platform_channel.dart';
import 'widgets/bidirectional_channel_dialog.dart';
import 'widgets/data_channel_dialog.dart';
import 'widgets/platform_channel_dialog.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({super.key});

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  String flutterResponse = '';
  String nativeResponse = '';

  @override
  void initState() {
    super.initState();
    initNativeMethodHandler(
      (String response) {
        setState(() {
          nativeResponse = response;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Channels'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReflectedButton(
                onPressed: () async {
                  final version = await getPlatformVersion();
                  getPlatformVersionDialog(context, version);
                },
                text: 'Ejercicio 1',
              ),
              const SizedBox(height: 20),
              ReflectedButton(
                onPressed: () async {
                  // Aquí irá la lógica para el segundo botón
                  final string = await concatenate('Hello Flutter');
                  concatenateDialog(context, string);
                },
                text: 'Ejercicio 2',
              ),
              const SizedBox(height: 20),
              ReflectedButton(
                onPressed: () async {
                  await sendDataToNative(
                    (String response) {
                      setState(() {
                        flutterResponse = response;
                      });
                    },
                  );
                  showResponseDialog(context, flutterResponse, nativeResponse);
                },
                text: 'Ejercicio 3',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReflectedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ReflectedButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.grey.withOpacity(0.3)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
