package com.example.native_code_methods

import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val platformChannel = "platform_channel"
    private val dataChannel = "data_channel"
    private val bidirectionalChannel = "bidirectionalChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        //the method channel is for getting the platform version
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            platformChannel
        ).setMethodCallHandler { call, result ->
            if (call.method == "getPlatformVersion") {
                val version = "Android " + Build.VERSION.RELEASE
                result.success(version)
            } else {
                result.notImplemented()
            }
        }

        //este MethodChannel recibe una cadena de texto y la devuelve concaenada con " - Native"
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            dataChannel
        ).setMethodCallHandler { call, result ->
            if (call.method == "concatenate") {
                val data = call.argument<String>("data")
                result.success(data + " - Native")
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            bidirectionalChannel
        ).setMethodCallHandler { call, result ->
            if (call.method == "flutterToNative") {
                val data = call.argument<String>("data")
                result.success(data + " recibido desde nativo")

                // Usar Handler para enviar un mensaje a Flutter después de 3 segundos


                    MethodChannel(
                        flutterEngine.dartExecutor.binaryMessenger,
                        bidirectionalChannel
                    ).invokeMethod("nativeToFlutter", "Hello from native")
            } else {
                result.notImplemented()
            }
        }

    }
}
