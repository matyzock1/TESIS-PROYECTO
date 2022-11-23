import 'package:components/screens/clinicas.dart';
import 'package:components/screens/googleMaps.dart';
import 'package:components/screens/gravedad2_screen.dart';
import 'package:components/screens/mapa.dart';
import 'package:flutter/material.dart';
import '../screens/clinicas_error.dart';
import '../screens/consultas_previas.dart';
import '../screens/login.dart';
import '../screens/password.dart';
import '../screens/register.dart';
import '../screens/screens.dart';
import '../screens/splash_screen.dart';
import '../screens/splash_screen2.dart';
import '../screens/splash_screen3.dart';
import '../screens/splash_screen4.dart';
import '../screens/splash_screen5.dart';
import '../screens/tab_screen.dart';
import '../screens/tips.dart';

class AppRoutes {
  static const initialRoute = 'splash';

  static Map<String, Widget Function(BuildContext)> routes = {
    'gravedad': (BuildContext context) => const GravedadScreen(
          datos: [],
        ),
    'gravedad2': (BuildContext context) => const Gravedad2Screen(
          datos: [],
        ),
    'formulario1': (BuildContext context) => const FormularioScreen(),
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
    'register': (BuildContext context) => const Home4Screen(),
    'tab': (BuildContext context) => const TabScreen(),
    'splash': (BuildContext context) => const SplashScreen(),
    'splash2': (BuildContext context) => const Splash2Screen(),
    'splash3': (BuildContext context) => const Splash3Screen(),
    'splash4': (BuildContext context) => const Splash4Screen(),
    'splash5': (BuildContext context) => const Splash5Screen(),
    'consultas': (BuildContext context) => const ConsultasScreen(),
    'clinicasError': (BuildContext context) => const ClinicasErrorScreen(),
  };

  static Route<dynamic> onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const ClinicasErrorScreen());
  }
}
