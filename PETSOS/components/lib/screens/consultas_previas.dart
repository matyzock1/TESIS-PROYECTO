import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultasScreen extends StatefulWidget {
  const ConsultasScreen({Key? key}) : super(key: key);

  @override
  State<ConsultasScreen> createState() => _ConsultasScreenState();
}

class _ConsultasScreenState extends State<ConsultasScreen> {
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
          'PET-SOS CONSULTAS PREVIAS',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color.fromARGB(255, 135, 6, 6),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('historial')
            .orderBy('Fecha', descending: true)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                return ListTile(
                  title: Row(
                    children: [
                      const Icon(
                        Icons.assignment_rounded,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                      Text(' ' + data['Enfermedad']),
                    ],
                  ),
                  subtitle: Text(
                    '            ' +
                        DateFormat.yMMMd().format(data['Fecha'].toDate()),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Row(
                                children: [
                                  Text(
                                    data['Enfermedad'] + ' ',
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  Image.network(
                                    'https://static.vecteezy.com/system/resources/thumbnails/000/079/896/small/paw-print-vector-icon.jpg',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              content: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Raza: ' + data['Raza'],
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17)),
                                    const TextSpan(
                                        text: '\n',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        )),
                                    TextSpan(
                                        text: 'Peso: ' + data['Peso'],
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17)),
                                    const TextSpan(
                                        text: '\n',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        )),
                                    TextSpan(
                                        text: 'Edad: ' + data['Edad'],
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17)),
                                    const TextSpan(
                                        text: '\n',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        )),
                                    const TextSpan(
                                        text: '\n',
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17)),
                                    for (var item in data['Sintomas'])
                                      TextSpan(
                                        text: "Sintoma: $item \n",
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.black),
                                      ),
                                    const TextSpan(
                                        text: '\n',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        )),
                                    TextSpan(
                                        text: 'Fecha: ' +
                                            DateFormat.yMMMd()
                                                .format(data['Fecha'].toDate()),
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17)),
                                  ],
                                ),
                              ));
                        });
                  },
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
