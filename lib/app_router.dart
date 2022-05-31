import 'package:flutter/material.dart';
import 'package:movie_app/presentation/screens/home.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: ((context) =>  Home()));
    }
    return null;
  }
}
