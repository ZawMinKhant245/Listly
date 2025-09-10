import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listly/models/user_data.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: Text("Total Collect",style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [
            Text("*****B",style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 2
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Colleted this month",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                    SizedBox(height: 5,),
                    Text("B ****",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30)),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Text('DashBoard',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.indigo,
              ),
              const SizedBox(height: 10,),
              Text("Member",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Consumer<UserProvider>(
                      builder: (context,data,child){
                        final members=data.members;
                        final me=data.me;
                        if(members.isEmpty){
                          return const Center(child: Text("No members found"),);
                        }
                        else{
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: members.length,
                              itemBuilder: (context,index){
                                final user=members[index];
                                final isCurrentUser = me != null && user.id == me.id;
                                return Container(
                                  color:isCurrentUser?Colors.orange:null,
                                  child: ListTile(
                                    leading: Icon(Icons.account_circle),
                                    title: Text(user.name),
                                    subtitle: Text(user.idNumber),

                                  ),
                                );
                              }
                          );
                        }

                  })

              )

            ],
          ),
        ),
      ),
    );
  }
}
