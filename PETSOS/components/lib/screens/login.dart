import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  final formKey = GlobalKey<FormState>();

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

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
                    Text('Datos invalidos', textAlign: TextAlign.center)
                  ],
                ),
              ),
            );
          });
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //necesario para realizar la validacion de campos
          key: formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                "PET-SOS",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              Lottie.asset(
                'assets/login.json',
                width: 200,
                height: 200,
              ),
              // const SizedBox(
              //   height: 10.0,
              // ),
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
                    return 'Demasiado corto';
                  } else if (value != null && value.length > 70) {
                    return 'Demasiado largo';
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
                height: 12.0,
              ),
              TextButton(
                child: const Text(
                  "Olvidaste tu contraseña?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 201, 40, 12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'pass');
                },
              ),
              const SizedBox(
                height: 10.0,
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
                        User? user = await loginUsingEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context);
                        if (user != null) {
                          // ignore: use_build_context_synchronously
                          user = FirebaseAuth.instance.currentUser!;
                          Navigator.pushReplacementNamed(context, 'splash4');
                        }
                      }
                    },
                    child: const Text(
                      "Iniciar Sesión",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
              const SizedBox(
                height: 10.0,
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
                      Navigator.pushNamed(context, 'register');
                    },
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
