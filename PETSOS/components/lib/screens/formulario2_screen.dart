import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Formulario2Screen extends StatefulWidget {
  const Formulario2Screen({Key? key}) : super(key: key);

  @override
  State<Formulario2Screen> createState() => _Formulario2ScreenState();
}

class _Formulario2ScreenState extends State<Formulario2Screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Formulario2Screen'),
      ),
    );
  }
}
