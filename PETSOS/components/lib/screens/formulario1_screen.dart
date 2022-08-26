import 'package:components/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({Key? key}) : super(key: key);

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  _FormularioScreenState();

  // ignore: prefer_typing_uninitialized_variables
  var selecCurrency,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PET-SOS PERRO',
          style: TextStyle(color: Colors.black54),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Raza',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Razas').snapshots(),
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
            height: 50,
          ),
          const Text(
            'Edad',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
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
                        Scaffold.of(context).showSnackBar(snackBar);
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
            height: 50,
          ),
          const Text(
            'Peso',
            textAlign: TextAlign.end,
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
                        Scaffold.of(context).showSnackBar(snackBar);
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
            height: 60,
          ),
          if (isApretado && isApretado2 && isApretado3)
            ElevatedButton(
                onPressed: () {
                  datosMascota.add(selecCurrency);
                  datosMascota.add(selecCurrency2);
                  datosMascota.add(selecCurrency3);
                  print(datosMascota);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SintomasScreen(a: datosMascota)));
                },
                child: const Text("SIGUIENTE"),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 32, 115, 224),
                  padding: EdgeInsets.all(20),
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
                child: const Text('SIGUIENTE'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.all(20),
                ))
        ],
      ),
    );
  }
}
