import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listly/models/note.dart';
import 'package:listly/provider/note_provider.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/note/note_add_screen.dart';
import 'package:provider/provider.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {

  Widget buildNoteCard(Note note,int index,String adminCheck){
    return InkWell(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteAddScreen(note: note,))),
      onLongPress: adminCheck == "Admin"?()   {
        showDialog(
          context: context,
          builder: (context){
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5,),
                    Text('Alert Dialog',style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700),),
                    SizedBox(height: 20,),
                    Text('Are you sure to DELETE note?',style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await Provider.of<NoteProvider>(context,listen: false).deleteNote(note.id);
                            Navigator.of(context).pop();
                            },
                          child: Text('Confirm'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          onPressed: ()=> Navigator.of(context).pop(),
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );

      }:null,
      splashColor: Colors.indigo,
      borderRadius: BorderRadius.circular(10),
      child: Card(
        color: Colors.indigo.shade100,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                note.title,
                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
               Text(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                note.content,
                style: TextStyle(fontSize: 13,),),
               Text(
                overflow: TextOverflow.ellipsis,
                   DateFormat('yyyy-MM-dd HH:mm').format(note.date),
              ),


            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Provider.of<UserProvider>(context,listen: false).getUserById(FirebaseAuth.instance.currentUser!.uid),
        builder: (context,snapShoot){
          if(snapShoot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return Consumer<UserProvider>
              (builder: (context,data,child){
                final adminCheck=data.me!.role;
                return  Scaffold(
                  appBar: AppBar(
                    title: Text('All Reports'),
                  ),
                  body:Consumer<NoteProvider>(
                      builder:(context,data,child){
                        final notes=data.notes;
                        if(notes.isEmpty){
                          return Center(child: Text('No Note Yet'),);
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child:  GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:2,mainAxisSpacing: 10,crossAxisSpacing: 10
                            ),
                            itemBuilder: (context,index){
                              return buildNoteCard(notes[index], index,adminCheck);
                            },
                            itemCount: notes.length,
                          ),
                        );
                      }
                  ),

                  floatingActionButton:adminCheck =="Admin"?FloatingActionButton(
                    backgroundColor: Colors.indigo.shade300,
                    onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteAddScreen())),child: Icon(Icons.add,color: Colors.white,),
                  ):null,
                );
            }
            );
          }
        }
    );

  }
}
