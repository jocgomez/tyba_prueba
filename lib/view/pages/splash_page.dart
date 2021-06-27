import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyba_prueba/model/user.dart';
import 'package:tyba_prueba/view/utils/style.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  User user;

  @override
  void initState() {
    Timer(Duration(seconds: 2), () async {
      // Si hay algun usuario logueado se va a home, si no va a login
      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: StylesElements.colorGreyBG,
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  child: Image.asset('assets/logo.png'),
                  margin: EdgeInsets.all(50),
                ),
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(StylesElements.colorPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
