import 'package:flutter/material.dart';

class ClinicasScreen extends StatelessWidget {
  const ClinicasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PET-SOS SINTOMAS',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 135, 6, 6),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://wonderfulengineering.com/wp-content/uploads/2016/02/white-wallpaper-21-768x480.jpg'))),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Selecciona el tipo de Atención',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'mapa');
                },
                child: const Text(
                  "  CLÍNICAS 24 HORAS  ",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Color.fromARGB(255, 135, 6, 6)),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'googlemaps');
                },
                child: const Text(
                  "CLINICAS HR NORMAL",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Color.fromARGB(255, 179, 169, 36)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
