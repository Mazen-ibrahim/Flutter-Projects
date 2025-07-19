import 'package:chat_app/widgets/user_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool visibilty = false;
  bool login = true;
  String enteredemail = '';
  String enteredpassword = '';

  void _submit() async {
    final valid = formkey.currentState!.validate();
    if (!valid) {
      return;
    }

    formkey.currentState!.save();
    try {
      if (login) {
        await _firebase.createUserWithEmailAndPassword(
          email: enteredemail,
          password: enteredpassword,
        );
      } else {
        await _firebase.signInWithEmailAndPassword(
          email: enteredemail,
          password: enteredpassword,
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "Authentication Failed",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        if (!login) UserImage(),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          onSaved: (value) {
                            enteredemail = value!;
                          },
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Must Enter Valid Email Address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          obscureText: !visibilty,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibilty = !visibilty;
                                });
                              },
                              icon: Icon(
                                visibilty
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onSaved: (value) {
                            enteredpassword = value!;
                          },
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password Must be at least 6 character long.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _submit,
                          child: Text(
                            login ? 'Login' : 'Sign up',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              login = !login;
                            });
                          },
                          child: Text(
                            login
                                ? "Create new account"
                                : 'Already have an account',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
