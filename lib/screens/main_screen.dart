import 'package:flutter/material.dart';
import 'package:listly/screens/auth_screen/sign_in_screen.dart';
import 'package:listly/screens/home_screen.dart';
import 'package:listly/screens/main_screen.dart';
import 'package:listly/screens/profile_screen.dart';
import 'package:listly/screens/record_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int currentIndex=0;
  List<Widget>listWidget=[
    HomeScreen(),
    RecordScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex =index;
            });
          },
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_chart),label: 'Record'),
            BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: 'Profile'),

          ]
      ),
    );

  }
}
