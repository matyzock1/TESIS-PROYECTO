import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash5Screen extends StatefulWidget {
  const Splash5Screen({Key? key}) : super(key: key);

  @override
  State<Splash5Screen> createState() => _Splash5ScreenState();
}

class _Splash5ScreenState extends State<Splash5Screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'consultas');
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
