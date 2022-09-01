import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GravedadScreen extends StatefulWidget {
  final List datos;
  const GravedadScreen({Key? key, required this.datos}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<GravedadScreen> createState() => _GravedadScreenState(datos);
}

class _GravedadScreenState extends State<GravedadScreen> {
  final enfermedad = FirebaseFirestore.instance.collection("Enfermedad");

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

  //metodo que trae los sintomas en un Array.

  // Future getData2() async {
  //   QuerySnapshot querySnapshot2 = await enfermedad
  //       .where("raza", isEqualTo: datos[0])
  //       .where("edad", isEqualTo: datos[1])
  //       .where("peso", isEqualTo: datos[2])
  //       .where("sintomas",
  //           arrayContainsAny: [datos[3], datos[4], datos[5]]).get();

  //   final map = querySnapshot2 as Map<dynamic, dynamic>;

  //   print(map);

  //   var nombreEnfermedad2 =
  //       querySnapshot2.docs.map((doc) => doc.data()).toString();
  //   print(nombreEnfermedad2);
  //   var remover = nombreEnfermedad2.replaceAll(RegExp('[{()}]'), '');
  //   print(remover);
  //   final comas = remover.split(",").toList();
  //   print(comas);
  // }

  Future getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await enfermedad
        .where("raza", isEqualTo: datos[0])
        .where("edad", isEqualTo: datos[1])
        .where("peso", isEqualTo: datos[2])
        .where("sintoma1", whereIn: [datos[3], datos[4], datos[5]]).get();

    nombreEnfermedad = querySnapshot.docs.map((doc) => doc.data()).toString();
    var remover = nombreEnfermedad.replaceAll(RegExp('[{()}]'), '');
    final comas = remover.split(",").toList();
    limpiarData(comas);
  }

  limpiarData(comas) {
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

    for (var a in comas) {
      if (a.contains("sintoma1")) {
        sintoma1Enfermedad = a;
        String result = sintoma1Enfermedad.substring(11);
        enfermedadActual.add(result);
      }
    }
    for (var a in comas) {
      if (a.contains("sintoma2")) {
        sintoma2Enfermedad = a;
        String result = sintoma2Enfermedad.substring(11);
        enfermedadActual.add(result);
      }
    }
    for (var a in comas) {
      if (a.contains("sintoma3")) {
        sintoma3Enfermedad = a;
        String result = sintoma3Enfermedad.substring(11);
        enfermedadActual.add(result);
      }
    }
    for (var a in comas) {
      if (a.contains("raza")) {
        razaEnfermedad = a;
        String result = razaEnfermedad.substring(7);
        enfermedadActual.add(result);
      }
    }
    for (var a in comas) {
      if (a.contains("peso")) {
        pesoEnfermedad = a;
        String result = pesoEnfermedad.substring(7);
        enfermedadActual.add(result);
      }
    }
    for (var a in comas) {
      if (a.contains("edad")) {
        edadEnfermedad = a;
        String result = edadEnfermedad.substring(7);
        enfermedadActual.add(result);
      }
    }
    for (var a in comas) {
      if (a.contains("estado")) {
        estadoEnfermedad = a;
        String result = estadoEnfermedad.substring(8);
        enfermedadActual.add(result);
      }
    }
    return enfermedadActual;
  }

  mostrarEnfermedad() {
    Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
    if (unOrdDeepEq(datos, enfermedadActual) == true) {
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
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Error!"),
              content: Text("No se encontró enfermedad existente"),
            );
          });
    }
  }

  @override
  void initState() {
    getData();
    // getData2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 228, 70, 59),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            'PET-SOS PERRO',
            style: TextStyle(color: Colors.black54),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              IconButton(
                  icon: Image.asset('assets/warning.png'),
                  iconSize: 200,
                  onPressed: () {}),
              const Text.rich(
                TextSpan(
                  text: 'Tu mascota posee un estado: ',
                  style: TextStyle(fontSize: 20), // default text style
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
                  Navigator.pushNamed(context, 'clinicas');
                },
                child: const Text(
                  "           SIGUIENTE           ",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: const Color.fromARGB(255, 255, 255, 255)),
              ),
              // ElevatedButton.icon(
              //     onPressed: () {},
              //     icon: Icons.arrow_forward_ios_sharp,
              //     label: Text("wea"))
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
