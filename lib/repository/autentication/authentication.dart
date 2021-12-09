import 'dart:async';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta.dart';
import 'package/user.dart';

// Error Sign in
class SignUpFailure implements Exception {}
// Error Log in
class LogInWithEmailAndPasswordFailure implements Exception {}
// Error Google log in
class LogInWithGoogleFailure implements Exception {}
// Error Close session
class LogOutFailure implements Exception {}

class AuthenticationRepository ({
  firebase_auth.FirebaseAuth firebaseAuth,
  GooleSignIn googleSignIn
}) : _firebaseAuth = firebase_auth ?? firebaseAuth.FirebaseAuth.instance,
  _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

final firebase_auth.firebase_auth _firebaseAuth;
final GoogleSignIn googleSignIn;

// Stream User -> actual usuario cuando el estado de authenticacion
Stream <User> get user{
  return _firebaseAuth.AuthStateChanges().map((firebaseUser){
    return firebaseUser == null ? User.empty : firebaseUser.toUser;
  });
}

// Registrar usuario con email y password

  Future<void> signUp ({
    @required String email,
    @required String password
  }) async {
    assert(email != null && password != null);
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }

 // Login Con google
 Future<void> logInWithGoogle() async {
  try{
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
  await _firebaseAuth.signInWithCredential(credential);
} on Exception {
  throw LogInWithGoogleFailure();
}


// Login con email and password
Future<void> logInWithEmailAndPassword({
  @required String email,
  @required String password
}) async {
  assert(email != null && password != null);
  try{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
  }on Exception{
    throw LogInWithEmailAndPasswordFailure();
  }
}

// Cerrar session
Future<void> LogOut() async {
  try{
    await Future.await([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  } on Exception{
    throw LogOutFailure();
  }
}

extension on firebase_auth.User {
  User get toUser{
    return User(id: uid,email: email, name: displayNeme, photo: photoURL);
  }
}