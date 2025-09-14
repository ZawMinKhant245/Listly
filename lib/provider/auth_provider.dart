import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{

  User? user;
  AuthProvider(){
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void setUser(){
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void clearUser(){
    user =null;
    notifyListeners();
  }

}