import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthClass {
  final _auth = FirebaseAuth.instance;

  // Register New User
  Future<User?> registerUser(String email, String pass, String confirmpass,
      String username, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      String UID = userCredential.user!.uid;
      return userCredential.user;

      //if get any exception
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

//login User

  Future<User?> loginUser(
      String email, String pass, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      String UID = userCredential.user!.uid;
      return userCredential.user;
      //if get any exception
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
