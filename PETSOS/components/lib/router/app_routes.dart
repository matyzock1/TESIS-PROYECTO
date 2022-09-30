import 'package:components/screens/clinicas.dart';
import 'package:components/screens/googleMaps.dart';
import 'package:components/screens/gravedad2_screen.dart';
import 'package:components/screens/mapa.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/password.dart';
import '../screens/screens.dart';
import '../screens/tips.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'gravedad': (BuildContext context) => const GravedadScreen(
          datos: [],
        ),
    'gravedad2': (BuildContext context) => const Gravedad2Screen(
          datos: [],
        ),
    'formulario1': (BuildContext context) => const FormularioScreen(),
    'formulario2': (BuildContext context) => const Formulario2Screen(),
    'sintomas1': (BuildContext context) => const SintomasScreen(
          a: [],
        ),
    'googlemaps': (BuildContext context) => GoogleMapsScreen(),
    'clinicas': (BuildContext context) => const ClinicasScreen(),
    'tips': (BuildContext context) => TipsScreen(
          datos: String,
        ),
    'mapa': (BuildContext context) => const HomePage(),
    'login': (BuildContext context) => const Home2Screen(),
    'pass': (BuildContext context) => const Home3Screen(),
  };

  static Route<dynamic> onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
