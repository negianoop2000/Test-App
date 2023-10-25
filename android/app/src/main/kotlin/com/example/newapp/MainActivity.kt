package com.example.newapp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import android.widget.Toast

class MainActivity : FlutterActivity() {
    private val CHANNEL = "message" // Replace with your actual channel name

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Set up a method channel to handle communication from Flutter
        val messenger: BinaryMessenger = flutterEngine.dartExecutor
        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "showMessage") {
                val message = call.arguments.toString()
                Toast.makeText(this@MainActivity, message, Toast.LENGTH_SHORT).show()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
