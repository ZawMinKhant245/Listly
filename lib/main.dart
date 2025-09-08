import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listly/firebase_options.dart';
import 'package:listly/screens/auth_screen/sign_in_screen.dart';
import 'package:listly/screens/home_screen.dart';
import 'package:listly/screens/main_screen.dart';
import 'package:listly/screens/profile_screen.dart';
import 'package:listly/screens/record_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

