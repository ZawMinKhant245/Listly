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
                }:null, child:me.role == "Admin"?Text("Disiable",style: TextStyle(color: Colors.black),)
              : CircleAvatar(
            radius: 20, // Increased size for prominence
            backgroundColor: Colors.white, // Border color
            child: CircleAvatar(
              radius: 57,
              backgroundImage:(me.image.isEmpty)? NetworkImage(
                  "https://th.bing.com/th?q=Grey+Person+Icon&w=120&h=120&c=1&rs=1&qlt=90&r=0&cb=1&pid=InlineBlock&mkt=en-WW&cc=TH&setlang=en&adlt=strict&t=1&mw=247")
                  :NetworkImage(me.image),
            ),
          ),
          )
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
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20, // Increased size for prominence
                            backgroundColor: Colors.white, // Border color
                            child: CircleAvatar(
                              radius: 57,
                              backgroundImage:(user.image.isEmpty)? NetworkImage(
                                  "https://th.bing.com/th?q=Grey+Person+Icon&w=120&h=120&c=1&rs=1&qlt=90&r=0&cb=1&pid=InlineBlock&mkt=en-WW&cc=TH&setlang=en&adlt=strict&t=1&mw=247")
                                  :NetworkImage(user.image),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.name,
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected?Colors.white:Colors.black,
                            ),
                          ),
                          Text(
                            user.idNumber,
                            style: TextStyle(color: isSelected?Colors.white:Colors.black,fontWeight: FontWeight.bold),
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



