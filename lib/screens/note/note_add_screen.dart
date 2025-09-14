import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listly/models/note.dart';
import 'package:listly/provider/note_provider.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/note/note_home_screen.dart';
import 'package:provider/provider.dart';

class NoteAddScreen extends StatefulWidget {
   NoteAddScreen({this.note,super.key});

  Note? note;
  @override
  State<NoteAddScreen> createState() => _NoteAddScreenState();
}


class _NoteAddScreenState extends State<NoteAddScreen> {

  final titleController=TextEditingController();
  final contentController=TextEditingController();
  final monthlyTotalController=TextEditingController();
  String? titleText,contentText,totalText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.note != null){
      titleController.text=widget.note!.title;
      contentController.text=widget.note!.content;
      monthlyTotalController.text=widget.note!.total;
      titleText =widget.note!.title;
      contentText =widget.note!.content;
      totalText =widget.note!.total;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Report'),
        actions: [
          TextButton(
              onPressed: titleText != null
                  && contentText != null
                  && totalText != null
                  && titleText!.isNotEmpty
                  && contentText!.isNotEmpty
                  && totalText!.isNotEmpty?(){
            final provider=Provider.of<NoteProvider>(context,listen: false);
            final docRef = FirebaseFirestore.instance
                .collection('notes')
                .doc();

            if(widget.note != null){
              provider.updateNoteById(
              widget.note!.id, {
                'title': titleController.text,
                'content': contentController.text,
                'date':DateTime.now(),
                'monthly': monthlyTotalController.text,}
              );
            }else{// auto-generate ID
              provider.createNote(
                  Note(
                      id: docRef.id,
                      title: titleController.text,
                      content: contentController.text,
                      date: DateTime.now(),
                      total: monthlyTotalController.text
                  )
              );
            }

            Navigator.of(context).pop();

          }:null, child: Text('save'))
        ],
      ),
      
      body: Consumer<UserProvider>(
          builder: (context,data,child){
            final adminCheck=data.me!.role;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      maxLines: 2,
                      readOnly: adminCheck =="Admin"?false:true,
                      onChanged: (String? value){
                        setState(() {
                          titleText =value;
                        });
                      },
                      controller: titleController,
                      style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      readOnly: adminCheck =="Admin"?false:true,
                      controller: contentController,
                      maxLines: 20,
                      onChanged: (String? value){
                        setState(() {
                          contentText =value;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Create Report',
                          border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('** You must fill all the report **',style: TextStyle(color: Colors.red),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Text('Current Month Collected :'),
                        const SizedBox(width: 40,),
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            readOnly: adminCheck =="Admin"?false:true,
                            controller:monthlyTotalController ,
                            keyboardType: TextInputType.number,// smaller text
                            onChanged: (String? value){
                              setState(() {
                                totalText =value;
                              });
                            },
                            decoration: InputDecoration(
                              isDense: true, // makes field compact
                              contentPadding:  EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              border:  OutlineInputBorder(),
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
            );
          }
      ),

    );
  }
}
