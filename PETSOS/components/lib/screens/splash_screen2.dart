import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash2Screen extends StatefulWidget {
  const Splash2Screen({Key? key}) : super(key: key);

  @override
  State<Splash2Screen> createState() => _Splash2ScreenState();
}

class _Splash2ScreenState extends State<Splash2Screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'formulario1');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset('assets/carga.json'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
