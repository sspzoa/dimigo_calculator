import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextStyle titleTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.primary,
  );
}

TextStyle subTitleTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 16.0,
    color: Theme.of(context).colorScheme.secondary,
  );
}

SystemUiOverlayStyle systemStyle = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.light,
);
