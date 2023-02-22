import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  //although i didn't give a value for it i promise i will give it a value before it is used

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Login')),
      body: Column(
            children: [
              TextField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: "Enter your email here",
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress, //@sign
                decoration: const InputDecoration(
                  hintText: "Enter your Password here",
                ),
              ),
              TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
    
                    try {
                      final userCredentials = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      print(userCredentials);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print("User not found");
                      } else if (e.code == 'wrong-password') {
                        print('Wrong Password');
                      } else {
                        print("SOMETHING ELSE HAPPEND");
                        print(e.code);
                      }
                    }
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/register/', 
                        (route) => false);
                  },
                  child: const Text("Not registered yet? Register here!"))
            ],
                ),
    );
  }
}
