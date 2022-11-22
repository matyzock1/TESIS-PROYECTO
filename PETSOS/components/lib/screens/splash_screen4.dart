import 'package:components/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash4Screen extends StatefulWidget {
  const Splash4Screen({Key? key}) : super(key: key);

  @override
  State<Splash4Screen> createState() => _Splash4ScreenState();
}

class _Splash4ScreenState extends State<Splash4Screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'tab');
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
