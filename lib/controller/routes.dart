import 'package:calculo_maluco/view/game.dart';
import 'package:calculo_maluco/view/intro.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String routeGame = "/game";
  static const String routeIntro = "/intro";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeGame:
        return MaterialPageRoute(builder: (_) => const Game());
      default:
        return MaterialPageRoute(builder: (_) => const Intro());
    }
  }
}
