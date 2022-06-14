import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// ignore: use_key_in_widget_constructors
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(primarySwatch: Colors.blue),
    ).modular();
  }
}