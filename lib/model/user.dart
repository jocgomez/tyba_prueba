import 'package:flutter/material.dart';

class User {
  const User({@required this.uid, this.email, this.name});

  final String uid;
  final String email;
  final String name;
}
