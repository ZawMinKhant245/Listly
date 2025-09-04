import 'package:flutter/material.dart';
import 'package:listly/screens/auth_screen/sign_in_screen.dart';
import 'package:listly/screens/main_screen.dart';
import 'package:listly/screens/record_screen.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SignInScreen()
    );
  }
}

