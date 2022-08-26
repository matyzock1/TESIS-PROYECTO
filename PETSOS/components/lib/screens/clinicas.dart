import 'package:flutter/material.dart';

class ClinicasScreen extends StatelessWidget {
  const ClinicasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PET-SOS CLINICAS',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapercave.com%2Fwp%2Fwp4579424.jpg&f=1&nofb=https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapercave.com%2Fwp%2Fwp4579424.jpg&f=1&nofb=11'))),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 160,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'googlemaps');
                },
                child: const Text(
                  "  CLÍNICAS 24 HORAS  ",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: const Color.fromARGB(255, 255, 0, 0)),
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
                    primary: const Color.fromARGB(255, 255, 238, 0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
