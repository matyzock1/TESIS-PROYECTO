import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home2Screen extends StatefulWidget {
  const Home2Screen({Key? key}) : super(key: key);

  @override
  State<Home2Screen> createState() => _Home2ScreenState();
}

class _Home2ScreenState extends State<Home2Screen> {
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
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No existe un usuario con este Email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
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
            "Iniciar sesion",
            style: TextStyle(
                color: Colors.black,
                fontSize: 44.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 44.0,
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
          const Text(
            "Olvidaste tu contraseña?",
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, 'home');
                  }
                },
                child: const Text(
                  "Iniciar Sesion",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ],
      ),
    );
  }
}
