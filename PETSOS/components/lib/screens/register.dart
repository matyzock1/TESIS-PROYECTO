import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    TextEditingController _nombreController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            "Registrarme",
            style: TextStyle(
                color: Colors.black,
                fontSize: 44.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: _nombreController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                hintText: "Ingresa tu Nombre",
                prefixIcon: Icon(Icons.face_outlined, color: Colors.black)),
          ),
          const SizedBox(
            height: 26.0,
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "Ingresa tu Email",
                prefixIcon: Icon(Icons.mail, color: Colors.black)),
          ),
          const SizedBox(
            height: 26.0,
          ),
          TextField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Ingresa tu Contraseña",
                prefixIcon: Icon(Icons.lock, color: Colors.black)),
          ),
          const SizedBox(
            height: 12.0,
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
                onPressed: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                            title: Text(
                          "Usuario registrado exitosamente",
                          style: TextStyle(fontSize: 20),
                        ));
                      }).then((value) => Navigator.pushNamed(context, 'login'));
                },
                child: const Text(
                  "Registrarme",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ],
      ),
    );
  }
}
