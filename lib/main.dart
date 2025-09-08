import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listly/firebase_options.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/auth_screen/sign_in_screen.dart';
import 'package:listly/screens/home_screen.dart';
import 'package:listly/screens/main_screen.dart';
import 'package:listly/screens/profile_screen.dart';
import 'package:listly/screens/record_screen.dart';
import 'package:provider/provider.dart';
import 'package:listly/provider/auth_provider.dart ' as AP;

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>UserProvider(), ),
          ChangeNotifierProvider(create: (context)=>AP.AuthProvider(), ),
        ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: Consumer<AP.AuthProvider>(
              builder:(context,data,child){
                return data.user == null?const SignInScreen():const MainScreen();
              }
          )
      ),
    );

  }
}

