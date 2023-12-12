import 'package:dimigo_calculator/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dimigo Calcualator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
        fontFamily: 'SUIT',
      ),
      initialRoute: RouteName.home,
      routes: namedRoutes,
    );
  }
}
