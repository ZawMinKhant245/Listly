import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listly/provider/note_provider.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/note/note_home_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final totalMember=Provider.of<UserProvider>(context,listen: false).members.length;
    final totalValue= Provider.of<NoteProvider>(context,listen: false).getTotalMonth();
    final totalMonthValue= Provider.of<NoteProvider>(context,listen: false).getCurrentMonthTotal();
    return  Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: const Text("Total Collected",style: TextStyle(fontWeight: FontWeight.bold),),
          actions:  [
            Text('${totalValue} B',style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                        Text("B ${totalMonthValue}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30)),
                      ],
                                ),
                  ),
                  Positioned( right: 10,bottom: 5,
                      child: TextButton(
                          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteHomeScreen())), child: Text('See report')))
                ],
              ),
              const SizedBox(height: 20,),
              // Text('DashBoard',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              // const SizedBox(height: 10,),
              // Container(
              //   width: double.infinity,
              //   height: 200,
              //   color: Colors.indigo,
              // ),
              // const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Members",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                Text("$totalMember",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              ],),
              const SizedBox(height: 10,),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Consumer<UserProvider>(
                      builder: (context,data,child){
                        final members=data.members;
                        final me=data.me;
                        if(members.isEmpty && me != null){
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
                                  color:isCurrentUser?Colors.indigo.shade200:null,
                                  child: ListTile(leading:  CircleAvatar(
                                    radius: 20, // Increased size for prominence
                                    backgroundColor: Colors.white, // Border color
                                    child: CircleAvatar(
                                      radius: 57,
                                      backgroundImage:(user.image.isEmpty)? NetworkImage(
                                          "https://th.bing.com/th?q=Grey+Person+Icon&w=120&h=120&c=1&rs=1&qlt=90&r=0&cb=1&pid=InlineBlock&mkt=en-WW&cc=TH&setlang=en&adlt=strict&t=1&mw=247")
                                          :NetworkImage(user.image),
                                    ),
                                  ),
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
