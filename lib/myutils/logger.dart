import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static printLog(String message) {
    if (kDebugMode) {
      log(message);
      print("--------------------------------------------------");
    }
  }
}
