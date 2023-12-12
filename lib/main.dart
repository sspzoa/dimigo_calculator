import 'dart:io';

import 'package:dimigo_calculator/main_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() {
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      FlutterDisplayMode.setHighRefreshRate();
    }
  }

  runApp(const MyApp());
}
