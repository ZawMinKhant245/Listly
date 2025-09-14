import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{
  List<User> users=[];
   User? me;

  final CollectionReference userRef=FirebaseFirestore.instance.collection('users');

  UserProvider() {
    // 👈 start listening automatically when provider is created
    userRef.snapshots().listen((querySnapshot) {
      users = querySnapshot.docs.map((doc) {
        return User.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
      notifyListeners();
    });
  }


  Future<void>createUser(User user)async{

    try{
      await userRef.doc(user.id).set(user.toJson());
    }catch(e){
      debugPrint('Error : $e');
    }
    notifyListeners();

  }

  Future<void> updateUserById(String userId, Map<String, dynamic> json) async {
    try {
      await userRef.doc(userId).update(json);

      final idx = users.indexWhere((u) => u.id == userId);
      if (idx != -1) {
        users[idx] = users[idx].copyWith(
          name: json['name'] ?? users[idx].name,
          phone: json['phone'] ?? users[idx].phone,
          email: json['email'] ?? users[idx].email,
          idNumber: json['idNumber'] ?? users[idx].idNumber,
          password: json['password'] ?? users[idx].password,
          role: json['role'] ?? users[idx].role,
          image: json['image'] ?? users[idx].image,
          isSelected: json['isSelected'] ?? users[idx].isSelected,
        );
        if (me != null && me!.id == userId) {
          me = users[idx];
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error : $e');
    }
  }



  // Future<User?>findUserByPhone(String phone)async {
  //   if (users.isEmpty) await fetchAllUser();
  //   List<User>result = users.where((e) => e.phone == phone).toList();
  //   if (result.length == 1) return result.first;
  //   return null;
  // }

  Future<User?>getUserById(String id,)async{
    print('UserId $id');
    try{
      DocumentSnapshot documentSnapshot=await userRef.doc(id).get();
      print('Doc:${documentSnapshot.data()}');
      me = User.fromJson(id, documentSnapshot.data() as Map<String,dynamic>);
      return me;
    }catch(e){
      debugPrint('Error : $e');
      return null;
    }

  }

  List<User> get members {
    return users.where((u) => u.role.toLowerCase() == "member").toList();
  }

  Future<void> clearAllSelections() async {
    final batch = FirebaseFirestore.instance.batch();

    for (var user in users) {
      batch.update(userRef.doc(user.id), {"isSelected": false});
    }

    await batch.commit();
  }

  Future<void> deleteUserById(String userId) async {
    try {
      await userRef.doc(userId).delete();
      debugPrint("User $userId deleted successfully");
    } catch (e) {
      debugPrint("Error deleting user: $e");
    }
  }

  Future<void> toggleSelection(String userId) async {
    final idx = users.indexWhere((u) => u.id == userId);
    if (idx == -1) return;

    final current = users[idx];
    final newValue = !current.isSelected;

    // Update local state first (optimistic update)
    users[idx] = current.copyWith(isSelected: newValue);
    notifyListeners();

    try {
      await userRef.doc(userId).update({"isSelected": newValue});
    } catch (e) {
      debugPrint("Error updating selection: $e");

      // rollback if Firestore fails
      users[idx] = current;
      notifyListeners();
    }
  }


}