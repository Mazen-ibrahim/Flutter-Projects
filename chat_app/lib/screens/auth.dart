import 'dart:io';

import 'package:chat_app/widgets/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  File? selectedImage;
  bool visibilty = false;
  bool login = true;
  bool uploading = false;
  String enteredusername = '';
  String enteredemail = '';
  String enteredpassword = '';
  String? imageurl;

  void _submit() async {
    final valid = formkey.currentState!.validate();
    if (!valid || (!login && selectedImage == null)) {
      return;
    }

    formkey.currentState!.save();
    try {
      setState(() {
        uploading = true;
      });
      if (login) {
        await _firebase.signInWithEmailAndPassword(
          email: enteredemail,
          password: enteredpassword,
        );
      } else {
        UserCredential userCredential = await _firebase
            .createUserWithEmailAndPassword(
              email: enteredemail,
              password: enteredpassword,
            );

        final Reference reference = FirebaseStorage.instance
            .ref()
            .child("User_Images")
            .child("${userCredential.user!.uid}.jpg");
        await reference.putFile(selectedImage!);
        imageurl = await reference.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
              'username': enteredusername,
              'email': enteredemail,
              'imageurl': imageurl,
            });
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
      setState(() {
        uploading = false;
      });
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
                        if (!login)
                          UserImage(
                            onPickImage: (File pickedImage) {
                              selectedImage = pickedImage;
                            },
                          ),
                        if (!login)
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: Icon(Icons.person),
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (value) {
                              enteredusername = value!;
                            },
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return 'Must Enter Valid Username';
                              }
                              return null;
                            },
                          ),
                        SizedBox(height: 25),
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
                        if (uploading) const CircularProgressIndicator(),
                        if (!uploading)
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
                        if (!uploading)
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
