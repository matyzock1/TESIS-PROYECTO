// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:components/screens/gravedad2_screen.dart';
import 'package:components/screens/screens.dart';
import 'package:flutter/material.dart';

class SintomasScreen extends StatefulWidget {
  final List a;
  const SintomasScreen({Key? key, required this.a}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SintomasScreen> createState() => _SintomasScreenState(a);
}

class _SintomasScreenState extends State<SintomasScreen> {
  List a = [];
  _SintomasScreenState(this.a);

  var selecCurrency,
      selecCurrency2,
      selecCurrency3,
      eleccion,
      eleccion2,
      eleccion3,
      estado,
      estado2,
      estado3;

  bool pressed = false;
  bool isApretado = false;
  bool isApretado2 = false;
  bool isApretado3 = false;

  List estadoGravedad = [];
  List nombresLista = [
    'Raza',
    'Edad',
    'Peso',
    'Sintoma1',
    'Sintoma2',
    'Sintoma3',
    'Estado'
  ];

  Map<String, dynamic> paket = {};
  final hasil = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              a.clear();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
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
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Selecciona los sintomas (Min. 3)',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              IconButton(
                  icon: Image.asset('assets/perroenfermo.png'),
                  iconSize: 170,
                  onPressed: () {}),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Sintomas')
                    .snapshots(),
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
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              selecCurrency = currencyValue;

                              isApretado = true;

                              FirebaseFirestore.instance
                                  .collection('Sintomas')
                                  .doc(selecCurrency)
                                  .get()
                                  .then((value) {
                                Map data = value.data() as Map;
                                // print(data[estado]);
                                estado = data['estado'];
                                estadoGravedad.add(estado);
                              });
                            });
                          },
                          value: selecCurrency,
                          hint: const Text('Selecciona un sintoma')),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Sintomas')
                    .snapshots(),
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
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              selecCurrency2 = currencyValue;

                              if (selecCurrency == selecCurrency2) {
                                String data = "El sintoma: " +
                                    selecCurrency +
                                    " no puede duplicarse.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(data),
                                      );
                                    });
                              } else if (selecCurrency == selecCurrency3) {
                                String data = "El sintoma: " +
                                    selecCurrency +
                                    " no puede duplicarse.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(data),
                                      );
                                    });
                              } else {
                                isApretado2 = true;
                              }

                              FirebaseFirestore.instance
                                  .collection('Sintomas')
                                  .doc(selecCurrency2)
                                  .get()
                                  .then((value) {
                                Map data = value.data() as Map;
                                // print(data[estado]);
                                estado2 = data['estado'];
                                estadoGravedad.add(estado2);
                              });
                            });
                          },
                          value: selecCurrency2,
                          hint: const Text('Selecciona un sintoma')),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Sintomas')
                    .snapshots(),
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
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              selecCurrency3 = currencyValue;

                              if (selecCurrency2 == selecCurrency3) {
                                String data = "El sintoma: " +
                                    selecCurrency2 +
                                    " no puede duplicarse.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(data),
                                      );
                                    });
                              } else if (selecCurrency3 == selecCurrency) {
                                String data = "El sintoma: " +
                                    selecCurrency3 +
                                    " no puede duplicarse.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(data),
                                      );
                                    });
                              } else {
                                isApretado3 = true;
                              }

                              FirebaseFirestore.instance
                                  .collection('Sintomas')
                                  .doc(selecCurrency3)
                                  .get()
                                  .then((value) {
                                Map data = value.data() as Map;
                                // print(data[estado]);
                                estado3 = data['estado'];
                                estadoGravedad.add(estado3);
                              });
                            });
                          },
                          value: selecCurrency3,
                          hint: const Text('Selecciona un sintoma')),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (isApretado && isApretado2 && isApretado3)
                ElevatedButton(
                    onPressed: () {
                      a.add(selecCurrency);
                      a.add(selecCurrency2);
                      a.add(selecCurrency3);

                      cambiarVentana(result) {
                        if (result == "Grave" || result == "grave") {
                          a.add(result);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GravedadScreen(
                                        datos: a,
                                      )));
                        }
                        if (result == "Leve" || result == "leve") {
                          a.add(result);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Gravedad2Screen(
                                        datos: a,
                                      )));
                        }
                      }

                      limpiarData(comas) {
                        for (var dato in comas) {
                          if (dato.contains("estado")) {
                            estado = dato;
                            String result = estado.substring(8);
                            cambiarVentana(result);
                          }
                        }
                      }

                      Future dataClean() async {
                        final consulta = FirebaseFirestore.instance
                            .collection('Razas')
                            .doc(a[0])
                            .collection(a[2])
                            .doc(a[1])
                            .collection('Enfermedad');

                        String sintoma1 = "sintomas" + '.' + a[3];
                        String sintoma2 = "sintomas" + '.' + a[4];
                        String sintoma3 = "sintomas" + '.' + a[5];

                        QuerySnapshot _consulta = await consulta
                            .where(sintoma1, isEqualTo: true)
                            .where(sintoma2, isEqualTo: true)
                            .where(sintoma3, isEqualTo: true)
                            .get();

                        final val =
                            _consulta.docs.map((doc) => doc.data()).toString();

                        if (val == "()") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AlertScreen()));
                        } else {
                          var remover = val.replaceAll(RegExp('[{()}]'), '');
                          final comas = remover.split(",").toList();

                          limpiarData(comas);
                        }
                      }

                      dataClean();
                    },
                    child: const Text("CONSULTAR ESTADO"),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 31, 163, 59),
                    ))
              else
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text(
                                "ERROR",
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                "Faltan campos por rellenar.",
                                textAlign: TextAlign.center,
                              ),
                            );
                          });
                    },
                    child: const Text('CONSULTAR ESTADO'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 135, 6, 6),
                    ))
            ]),
          ),
        ));
  }
}
