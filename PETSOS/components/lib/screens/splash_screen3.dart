import 'package:components/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash3Screen extends StatefulWidget {
  const Splash3Screen({Key? key}) : super(key: key);

  @override
  State<Splash3Screen> createState() => _Splash3ScreenState();
}

class _Splash3ScreenState extends State<Splash3Screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'clinicas');
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
