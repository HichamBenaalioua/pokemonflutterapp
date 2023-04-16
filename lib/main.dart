import 'package:flutter/material.dart';
import 'package:pokimonapp/home.dart';
import 'package:pokimonapp/details.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    routes: {
      '/home': (context) => const Home(),
      '/details': (context) => const Details()
    },
  ));
}
