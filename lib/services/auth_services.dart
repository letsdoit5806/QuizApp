import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/model/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final baseUrl = "https://186d-27-59-100-69.ngrok-free.app";

  Future<UserCredential> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await signUpDb(
        UserModel(uid: userCredential.user!.uid, name: name, email: email),
      );
      return userCredential;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signUpDb(UserModel user) async {
    http
        .post(
          Uri.parse('$baseUrl/api/users/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(user.toJson()),
        )
        .then((response) {
          if (response.statusCode == 200) {
            print('User signed up successfully');
          } else {
            throw Exception('Failed to sign up user: ${response.body}');
          }
        });
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}
