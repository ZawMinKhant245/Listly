import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{
  List<User> users=[];
   User? me;

  final CollectionReference userRef=FirebaseFirestore.instance.collection('users');

  Future<void>fetchAllUser()async{
    QuerySnapshot querySnapshot=await userRef.get();
    users=querySnapshot.docs.map((doc){
      return User.fromJson(doc.id,doc.data() as Map<String,dynamic>);
    }).toList();
    notifyListeners();
  }

  Future<void>createUser(User user)async{

    try{
      await userRef.doc(user.id).set(user.toJson());
    }catch(e){
      debugPrint('Error : $e');
    }

  }

  Future<void>updateUserById(String userId,Map<String,dynamic>json)async{
    try{
      await userRef.doc(userId).set(json);
    }catch(e){
      debugPrint('Error : $e');
    }
    notifyListeners();

  }

  Future<User?>findUserByPhone(String phone)async {
    if (users.isEmpty) await fetchAllUser();
    List<User>result = users.where((e) => e.phone == phone).toList();
    if (result.length == 1) return result.first;
    return null;
  }

  Future<User?>getUserById(String id,)async{
    print('UserId $id');
    try{
      DocumentSnapshot documentSnapshot=await userRef.doc(id).get();
      print('Doc:${documentSnapshot.data()}');
      me = User.fromJson(id, documentSnapshot.data() as Map<String,dynamic>);
      notifyListeners();
      return me;
    }catch(e){
      debugPrint('Error : $e');
      return null;
    }

  }

  List<User> get members {
    return users.where((u) => u.role.toLowerCase() == "member").toList();
  }
  List<User> get admin {
    return users.where((u) => u.role.toLowerCase() == "admin").toList();
  }

}