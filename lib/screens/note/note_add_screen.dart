import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listly/models/note.dart';
import 'package:listly/provider/note_provider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.note != null){
      titleController.text=widget.note!.title;
      contentController.text=widget.note!.content;
      monthlyTotalController.text=widget.note!.total;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Report'),
        actions: [
          TextButton(onPressed: (){
            final provider=Provider.of<NoteProvider>(context,listen: false);

            final docRef = FirebaseFirestore.instance
                .collection('notes')
                .doc(); // auto-generate ID
            provider.createNote(
                Note(
                    id: docRef.id,
                    title: titleController.text,
                    content: contentController.text,
                    date: DateTime.now(),
                    total: monthlyTotalController.text
                )
            );
            Navigator.of(context).pop();

          }, child: Text('save'))
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                maxLines: 2,
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: contentController,
                maxLines: 20,
                decoration: InputDecoration(
                    hintText: 'Create Report',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('Current Month Collected :'),
                  const SizedBox(width: 40,),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      controller:monthlyTotalController ,
                      keyboardType: TextInputType.number,// smaller text
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
      ),
    );
  }
}
