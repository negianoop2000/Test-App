import 'package:flutter/services.dart';

class PlatformChannel {
  static const platform = MethodChannel('message');

  static Future<void> showMessage(String message) async {
    try {
      await platform.invokeMethod('showMessage', message);
    } on PlatformException catch (e) {
      print("Failed to show message: ${e.message}");
    }
  }
}
