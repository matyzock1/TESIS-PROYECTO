import 'package:components/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({Key? key}) : super(key: key);

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  _FormularioScreenState();

  // ignore: prefer_typing_uninitialized_variables
  var selecCurrency,
      // ignore: prefer_typing_uninitialized_variables
      selecCurrency2,
      selecCurrency3,
      eleccion,
      eleccion2,
      eleccion3;

  List datosMascota = [];
  bool isApretado = false;
  bool isApretado2 = false;
  bool isApretado3 = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(
                'Prevenir enfermedades',
                style: TextStyle(fontSize: 30),
              ),
              content: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Lavate las manos: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                    TextSpan(
                        text:
                            'Parece un consejo muy básico, pero lavarse las manos es esencial para prevenir el contagio de enfermedades entre los miembros de tu familia, incluidos tus perros.',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    TextSpan(
                        text: 'Visita al veterinario regularmente: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                    TextSpan(
                        text:
                            'lleva a tu perro al veterinario al menos una vez al año para una revisión médica general.',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    TextSpan(
                        text: 'Vacunación (y llévala al día): ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                    TextSpan(
                        text:
                            'asegúrate de que tu perro tiene todas las vacunas necesarias según su entorno y estilo de vida.',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    TextSpan(
                        text: 'Limpieza: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                    TextSpan(
                        text:
                            'limpia frecuentemente el entorno de tu perro (el suelo, su cama, sus juguetes…) para dejarlo libre de objetos dañinos (como cristales, espigas o astillas), bacterias y parásitos.',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    TextSpan(
                        text: 'Observa la dieta de tu perro: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                    TextSpan(
                        text:
                            'los perros a menudo se ponen malos cuando comen alimentos en mal estado, beben agua contaminada o ingieren sustancias tóxicas para ellos.',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                  ],
                ),
              ));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
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
        backgroundColor: const Color.fromARGB(255, 135, 6, 6),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://wonderfulengineering.com/wp-content/uploads/2016/02/white-wallpaper-21-768x480.jpg'))),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Lottie.network(
              'https://assets4.lottiefiles.com/packages/lf20_o1JRaPxx1E.json',
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Elige una Raza',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Razas').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Loading');
                } else {
                  List<DropdownMenuItem> currencyItems = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    currencyItems.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.id,
                        ),
                        value: snap.id,
                      ),
                    );
                    eleccion = currencyItems;
                  }
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<dynamic>(
                      items: eleccion,
                      onChanged: (currencyValue) {
                        var snackBar = SnackBar(
                            content: Text('Se seleccionó $currencyValue'));
                        // ignore: deprecated_member_use
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          selecCurrency = currencyValue;
                          isApretado = true;
                        });
                      },
                      value: selecCurrency,
                      hint: const Text('Seleccione una raza'),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Elige una Edad',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Edad').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Loading');
                } else {
                  List<DropdownMenuItem> currencyItems2 = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    currencyItems2.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.id,
                        ),
                        value: snap.id,
                      ),
                    );
                    eleccion2 = currencyItems2;
                  }
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<dynamic>(
                        items: eleccion2,
                        onChanged: (currencyValue) {
                          var snackBar = SnackBar(
                              content: Text('Se seleccionó $currencyValue'));
                          // ignore: deprecated_member_use
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            selecCurrency2 = currencyValue;
                            isApretado2 = true;
                          });
                        },
                        value: selecCurrency2,
                        hint: const Text('Seleccione una edad')),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Elige un Peso',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Peso').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Loading');
                } else {
                  List<DropdownMenuItem> currencyItems3 = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    currencyItems3.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.id,
                        ),
                        value: snap.id,
                      ),
                    );
                    eleccion3 = currencyItems3;
                  }
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<dynamic>(
                        items: eleccion3,
                        onChanged: (currencyValue) {
                          var snackBar = SnackBar(
                              content: Text('Se seleccionó $currencyValue'));
                          // ignore: deprecated_member_use
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            selecCurrency3 = currencyValue;
                            isApretado3 = true;
                          });
                        },
                        value: selecCurrency3,
                        hint: const Text('Seleccione un peso')),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            if (isApretado && isApretado2 && isApretado3)
              ElevatedButton(
                  onPressed: () {
                    datosMascota.add(selecCurrency);
                    datosMascota.add(selecCurrency2);
                    datosMascota.add(selecCurrency3);
                    // ignore: avoid_print
                    print(datosMascota);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SintomasScreen(a: datosMascota)));
                  },
                  child: const Text("SIGUIENTE"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 31, 163, 59),
                    padding: const EdgeInsets.all(15),
                  ))
            else
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text(
                              "ERROR!",
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "Faltan campos por rellenar.",
                              textAlign: TextAlign.center,
                            ),
                          );
                        });
                  },
                  child: const Text('SIGUIENTE'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 135, 6, 6),
                    padding: const EdgeInsets.all(15),
                  ))
          ],
        ),
      ),
    );
  }
}
