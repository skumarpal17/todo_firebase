import 'package:flutter/material.dart';

class RouteServices{
  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    final agrs = routeSettings.arguments;
    switch (routeSettings.name){
      case "":
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: const Text("page not found"),),
      );
    });
  }
}