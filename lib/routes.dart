import 'package:dimigo_calculator/screens/home_screen.dart';
import 'package:dimigo_calculator/screens/input_screen.dart';
import 'package:dimigo_calculator/screens/result_screen.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const home = "/";
  static const input = "/input";
  static const result = "/result";
}

var namedRoutes = <String, WidgetBuilder>{
  RouteName.home: (context) => const HomeScreen(),
  RouteName.input: (context) => InputScreen(),
  RouteName.result: (context) => ResultScreen(),
};
