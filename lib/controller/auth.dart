import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tyba_prueba/model/user.dart';
import 'package:tyba_prueba/view/components/toast_component.dart';

class Auth {
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email, name: user.displayName) : null;
  }

  Stream<User> get user {
    return fireBaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // Registrar un usuario nuevo por email
  void register(String email, String password, BuildContext context) async {
    try {
      final FirebaseUser user = (await fireBaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, 'splash', (route) => false);
        ToastComponent.toastMessage(message: "Se ha registrado correctamente.", isLong: false);
      }
    } on PlatformException catch (e) {
      // Retroalimentación
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        ToastComponent.toastMessage(
            message: "Este correo ya se encuentra registrado.", isLong: false);
      }
    }
  }

  // Ingresar a un usuario con email
  void signIn(String email, String password, BuildContext context) async {
    try {
      final FirebaseUser user = (await fireBaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, 'splash', (route) => false);
        ToastComponent.toastMessage(
            message: "Bienvenid(a) a RestaurApp by Mr.Bolat", isLong: false);
      }
    } on PlatformException catch (e) {
      // Retroalimentación
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        ToastComponent.toastMessage(
            message: "Este correo no se encuentra registrado.", isLong: false);
      }
      if (e.code == 'ERROR_WRONG_PASSWORD') {
        ToastComponent.toastMessage(message: "La contraseña es incorrecta.", isLong: false);
      }
    }
  }

  Future<User> currentUser() async {
    final FirebaseUser user = await fireBaseAuth.currentUser();
    return _userFromFirebaseUser(user);
  }

  Future<void> signOut() async {
    return fireBaseAuth.signOut();
  }
}
