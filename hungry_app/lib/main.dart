import 'package:flutter/material.dart';
import 'package:full_app/features/auth/views/signup_view.dart';
import 'package:full_app/root.dart';
import 'package:full_app/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungry App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      // theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: SignupView(),
    );
  }
}
