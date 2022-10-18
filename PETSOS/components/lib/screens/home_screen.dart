import 'package:components/screens/utilidades/colores.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'PET-SOS',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("00d5ff"),
              hexStringToColor("371ed2")
            ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 200,
              ),
              IconButton(
                  icon: Image.asset('assets/perro.png'),
                  iconSize: 100,
                  onPressed: () {
                    Navigator.pushNamed(context, 'formulario1');
                  }),
              const SizedBox(
                height: 60,
              ),
              const SizedBox(
                height: 179,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("CERRA SESION"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 31, 163, 59),
                    padding: const EdgeInsets.all(15),
                  )),
            ],
          ),
        ));
  }
}
