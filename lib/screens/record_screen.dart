import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}


class _RecordScreenState extends State<RecordScreen> {

  Future<void>getUser()async{
    Provider.of<UserProvider>(context, listen: false).fetchAllUser();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

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
                   return Scaffold(
                     appBar: AppBar(
                       title:Icon(Icons.account_circle),
                     ),
                     body: SingleChildScrollView(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             Container(
                               height: 200,
                               decoration: BoxDecoration(
                                   color: Colors.grey,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                             ),
                             const SizedBox(height: 20,),
                             SizedBox(
                               height: 150,
                               child: PageView(
                                 children: [
                                   Container(
                                     height: 200,
                                     margin: EdgeInsets.symmetric(horizontal: 5),
                                     decoration: BoxDecoration(
                                         color: Colors.red,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                   ),
                                   Container(
                                     height: 200,margin: EdgeInsets.symmetric(horizontal: 5),
                                     decoration: BoxDecoration(
                                         color: Colors.green,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                   ),
                                   Container(
                                     height: 200,margin: EdgeInsets.symmetric(horizontal: 5),
                                     decoration: BoxDecoration(
                                         color: Colors.orange,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             const SizedBox(height: 20,),
                             Container(
                               height: 200,
                               decoration: BoxDecoration(
                                   color: Colors.teal,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                             ),


                           ],
                         ),
                       ),
                     ),
                   );

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
  String? _selectedUserId; // 👈 track selected user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle),
        elevation: 3,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Consumer<UserProvider>(
          builder: (context, data, child) {
            final members = data.members;
            if (members.isEmpty) {
              return const Center(child: Text("No members found"));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final user = members[index];
                  return RadioListTile<String>(
                    title: Text(user.name),
                    subtitle: Text(user.idNumber),
                    value: user.id, // each user has unique ID
                    groupValue: _selectedUserId,
                    onChanged: (value) {
                      setState(() {
                        _selectedUserId = value; // update selection
                      });
                    },
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

