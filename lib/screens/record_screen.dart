import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/profile_screen.dart';
import 'package:listly/screens/search_screen.dart';
import 'package:listly/screens/widgets/widget.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}


class _RecordScreenState extends State<RecordScreen> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:Provider.of<UserProvider>(context,listen: false).getUserById(FirebaseAuth.instance.currentUser!.uid),
        builder: (context,snapShoot){
         if(snapShoot.connectionState ==ConnectionState.waiting){
           return Scaffold(
               body: Center(
                   child:CircularProgressIndicator(color: Colors.teal,),
               ),
           );
         }else{
           return  Consumer<UserProvider>(
               builder: (context,data,child){
                 final me=data.me;
                 if(me == null){
                   return const Center(child: CircularProgressIndicator(color:Colors.indigo));
                 }
                 if(me.role=='Admin'){
                   return  AdminWidget();
                 }else{
                   return AdminWidget();
                 }

               }
           );
         }
        }
    );

  }
}

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  List<String> _selectedUserIds = [];
  bool isAdmin=false;
  bool CheckAdmin(){
    final me=Provider.of<UserProvider>(context,listen: false).me;
    if(me == null){
      return isAdmin;
    }
    if(me.role == 'Admin'){
      return true;
    }else{
      return false;
    }
  }

  Widget textfromFiel(){
    return InkWell(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen())),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
          child: Text('Search',textAlign: TextAlign.start,style: TextStyle(fontSize: 18),),
        ),
      ),
    );
        
  }


  @override
  Widget build(BuildContext context) {
    final me=Provider.of<UserProvider>(context,listen: false).me;
    return Scaffold(
      appBar: AppBar(
        title: textfromFiel(),
        actions: [
          TextButton(
            iconAlignment: IconAlignment.end,
              onPressed:me!.role == "Admin"?() async {
                setState(() {
                  _selectedUserIds.clear();
                });
                await Provider.of<UserProvider>(context, listen: false)
                    .clearAllSelections(); // reset in Firestore
                }:null, child: Text("Disiable",style: TextStyle(color: Colors.black),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UserProvider>(
          builder: (context, data, child) {
            final members = data.members;
            final me=data.me;
            if (members.isEmpty&& me ==null) {
              return const Center(child: Text("No members found"));
            } else {
              return GridView.builder(
                itemCount: members.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 per row
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final user = members[index];
                  final isSelected = user.isSelected ?? false;

                  return GestureDetector(
                    onTap: (me != null && me.role == 'Admin')
                        ? () async {
                      final newValue = !isSelected;
                      // Update Firestore
                      await Provider.of<UserProvider>(context, listen: false)
                          .updateUserById(user.id, {"isSelected": newValue});
                    }
                        : null,

                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            user.idNumber,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}



