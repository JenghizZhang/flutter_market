import 'package:flutter/material.dart';
import 'package:flutter_base/pages/Login/index.dart';
import 'package:flutter_base/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(initialRoute: "/", routes: getRoutes());
}

Map<String, Widget Function(BuildContext)> getRoutes() {
  return {
    "/": (context) => MainPage(), 
    "/login": (context) => LoginPage(),
  };
}
