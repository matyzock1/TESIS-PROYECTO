import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:components/models/user.dart' as model;

class Home4Screen extends StatefulWidget {
  const Home4Screen({Key? key}) : super(key: key);

  @override
  State<Home4Screen> createState() => _Home4ScreenState();
}

class _Home4ScreenState extends State<Home4Screen> {
  Future<FirebaseApp> _initlizeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initlizeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // ignore: prefer_final_fields, non_constant_identifier_names
  final TextEditingController _nombreController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _nombreController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //necesario para realizar la validacion de campos
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                "PET-SOS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Registro",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.length < 4) {
                    return 'Nombre demasiado corto';
                  } else if (value != null && value.length > 10) {
                    return 'Nombre demasiado largo';
                  } else {
                    return null;
                  }
                },
                controller: _nombreController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    hintText: "Ingresa tu Nombre",
                    prefixIcon: Icon(Icons.face_outlined, color: Colors.black)),
              ),
              const SizedBox(
                height: 26.0,
              ),
              TextFormField(
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Introduzca un email válido'
                        : null,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "Ingresa tu Email",
                    prefixIcon: Icon(Icons.mail, color: Colors.black)),
              ),
              const SizedBox(
                height: 26.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.length < 6) {
                    return 'Contraseña demasiado corta';
                  } else if (value != null && value.length > 70) {
                    return 'Contraseña demasiado larga';
                  } else {
                    return null;
                  }
                },
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                    hintText: "Ingresa tu Contraseña",
                    prefixIcon: Icon(Icons.lock, color: Colors.black)),
              ),
              const SizedBox(
                height: 26.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.length < 6) {
                    return 'Contraseña demasiado corta';
                  } else if (value != null && value.length > 70) {
                    return 'Contraseña demasiado larga';
                  } else {
                    return null;
                  }
                },
                controller: _confirmPasswordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Repetir Contraseña",
                    prefixIcon: Icon(Icons.lock, color: Colors.black)),
              ),
              const SizedBox(
                height: 22.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                    fillColor: const Color.fromARGB(255, 201, 40, 12),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () async {
                      final isValidForm = formKey.currentState!.validate();

                      if (isValidForm) {
                        if (_confirmPasswordController.text ==
                            _passwordController.text) {
                          var emailUser = await registro(
                              username: _nombreController.text,
                              email: _emailController.text,
                              password: _passwordController.text);
                          if (emailUser == "fallo email") {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Error',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const [
                                          Text('Correo ya registrado',
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (emailUser == 'Exitoso') {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'PET-SOS',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const [
                                          Text('Registro exitoso',
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Error',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const [
                                        Text(
                                            'Las contraseñas deben ser ídenticas.',
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                    },
                    child: const Text(
                      "Registrarme",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> registro({
    required String username,
    required String email,
    required String password,
  }) async {
    String res = "Ocurrio un error";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        //registrar al usuario
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //añadir los otros datos a la base de datos
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "Exitoso";
      }
    } catch (error) {
      if (error.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        res = "fallo email";
      } else {
        res = 'ERROR';
      }
    }
    return res;
  }
}
