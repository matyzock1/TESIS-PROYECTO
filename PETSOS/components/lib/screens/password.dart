import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home3Screen extends StatefulWidget {
  const Home3Screen({Key? key}) : super(key: key);

  @override
  State<Home3Screen> createState() => _Home3ScreenState();
}

class _Home3ScreenState extends State<Home3Screen> {
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
            return const PassScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PassScreen extends StatefulWidget {
  const PassScreen({Key? key}) : super(key: key);

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        autovalidateMode: AutovalidateMode
            .onUserInteraction, //necesario para realizar la validacion de campos
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "PET-SOS",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Recuperar Contraseña",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 33.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 44.0,
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
              height: 44.0,
            ),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                  fillColor: const Color.fromARGB(255, 201, 40, 12),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    final isValidForm = formKey.currentState!.validate();

                    if (isValidForm) {
                      RecuperarContra();
                    }
                  },
                  child: const Text(
                    "Restablecer Contraseña",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future RecuperarContra() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          .then((value) => showDialog(
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
                        Text(
                            'Si la cuenta existe el enlace fue enviado al correo electronico',
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                );
              }));
    } on FirebaseAuthException {
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
                    Text(
                        'Si la cuenta existe el enlace fue enviado al correo electronico',
                        textAlign: TextAlign.center)
                  ],
                ),
              ),
            );
          });
    }
  }
}
