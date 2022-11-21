import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import 'alert_screen.dart';

class GravedadScreen extends StatefulWidget {
  final List datos;

  const GravedadScreen({Key? key, required this.datos}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<GravedadScreen> createState() => _GravedadScreenState(datos);
}

class _GravedadScreenState extends State<GravedadScreen> {
  List datos = [];
  List enfermedadActual = [];

  _GravedadScreenState(this.datos);
  String nombreEnfermedad = "";
  String enfermedadName = "";
  String enfermedadDescription = "";
  String razaEnfermedad = "";
  String edadEnfermedad = "";
  String pesoEnfermedad = "";
  String sintoma1Enfermedad = "";
  String sintoma2Enfermedad = "";
  String sintoma3Enfermedad = "";
  String estadoEnfermedad = "";
  String descripcionEnfermedad = "";
  String datosAnimal = "";
  String result = "";

  //Generar cadena aleatoria

  generarCadena(){
    var cadena = "";
    var longitud = 10;
    var caracteres = "abcdefghijklmnopqrstuvwxyz0123456789";
    var caracteresLength = caracteres.length;
    for (var i = 0; i < longitud; i++) {
      cadena = cadena + caracteres[Random().nextInt(caracteresLength)];
    }
    return cadena;
  }

  Future dataClean() async {
    final consulta = FirebaseFirestore.instance
        .collection('Razas')
        .doc(datos[0])
        .collection(datos[2])
        .doc(datos[1])
        .collection('Enfermedad');

    String sintoma1 = "sintomas" + '.' + datos[3];
    String sintoma2 = "sintomas" + '.' + datos[4];
    String sintoma3 = "sintomas" + '.' + datos[5];

    QuerySnapshot _consulta = await consulta
        .where(sintoma1, isEqualTo: true)
        .where(sintoma2, isEqualTo: true)
        .where(sintoma3, isEqualTo: true)
        .get();

    final val = _consulta.docs.map((doc) => doc.data()).toString();

    if (val == "()") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AlertScreen()));
    } else {
      var remover = val.replaceAll(RegExp('[{()}]'), '');
      final comas = remover.split(",").toList();

      limpiarDatos(comas);
    }
  }

  limpiarDatos(comas) {
    for (var e in comas) {
      if (e.contains("nombre")) {
        enfermedadName = e;
        String result = enfermedadName.substring(9);
        nombreEnfermedad = result;
      }
    }

    for (var e in comas) {
      if (e.contains("description")) {
        enfermedadDescription = e;
        String result = enfermedadDescription.substring(14);
        descripcionEnfermedad = result;
      }
    }
  }

  mostrarEnfermedad() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              nombreEnfermedad,
              style: const TextStyle(fontSize: 30),
            ),
            content: Text(
              descripcionEnfermedad,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          );
        });
  }

  Future createHistorial() async {
    // var now = DateTime.now();
    // var formatter = DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(now);

    final docHistorial = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('historial')
        .doc();

    final json = {
      'Enfermedad': nombreEnfermedad,
      'Raza': datos[0],
      'Edad': datos[1],
      'Peso': datos[2],
      'Sintomas': [datos[3], datos[4], datos[5]],
      'Fecha': DateTime.now()
    };

    await docHistorial.set(json);
  }

  @override
  void initState() {
    dataClean();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 149, 20, 20),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            'PET-SOS PERRO',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255), //change your color here
          ),
          backgroundColor: Color.fromARGB(255, 135, 6, 6),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Lottie.network(
                'https://assets8.lottiefiles.com/packages/lf20_Tkwjw8.json',
                width: 270,
                height: 270,
              ),
              const Text.rich(
                TextSpan(
                  text: 'Tu mascota posee un estado: ',
                  style: TextStyle(
                      fontSize: 20, color: Colors.white), // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Grave.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    mostrarEnfermedad();
                    // getData2();
                  },
                  child: const Text(
                    'POSIBLE ENFERMEDAD',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: const Color.fromARGB(255, 251, 244, 21),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  createHistorial();
                  Navigator.pushNamed(context, 'clinicas');
                },
                child: const Text(
                  "               SIGUIENTE               ",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
