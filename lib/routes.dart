import 'package:flutter/material.dart';
import 'package:tyba_prueba/view/pages/home_page.dart';
import 'package:tyba_prueba/view/pages/login_page.dart';
import 'package:tyba_prueba/view/pages/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      // Rutas de la aplicación.
      '/': (BuildContext context) => LoginPage(),
      'splash': (BuildContext context) => SplashPage(),
      'home': (BuildContext context) => HomePage(),
    };
