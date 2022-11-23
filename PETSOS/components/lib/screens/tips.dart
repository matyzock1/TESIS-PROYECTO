import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class TipsScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var datos;

  TipsScreen({Key? key, required this.datos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'PET-SOS TIPS',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: const Color.fromARGB(255, 135, 6, 6),
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
                  height: 60,
                ),
                Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_dicn56pf.json',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Haz click aquí para conocer los tips:',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("¿Que hacer?"),
                            content: Text(datos),
                          );
                        });
                  },
                  child: const Text(
                    "  TIPS ASOCIADOS  ",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(30),
                      primary: const Color.fromARGB(255, 135, 6, 6)),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
