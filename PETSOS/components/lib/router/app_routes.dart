import 'package:components/screens/clinicas.dart';
import 'package:components/screens/googleMaps.dart';
import 'package:components/screens/gravedad2_screen.dart';
import 'package:components/screens/mapa.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../screens/tips.dart';

class AppRoutes {
  static const initialRoute = 'home';

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
    'tips': (BuildContext context) => const TipsScreen(),
    'mapa': (BuildContext context) => const HomePage(),
  };

  static Route<dynamic> onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
