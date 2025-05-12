
import 'package:flutter/material.dart';
import 'package:testfinal/controlpage.dart';
import 'package:testfinal/finalpage.dart';
import 'package:testfinal/homepage.dart';
import 'package:testfinal/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePgae()
    );
  }
}

