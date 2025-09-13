import 'package:flutter/material.dart';
import 'package:listly/screens/note/note_home_screen.dart';

class NoteAddScreen extends StatefulWidget {
  const NoteAddScreen({super.key});

  @override
  State<NoteAddScreen> createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Report'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>NoteHomeScreen()));
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
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                maxLines: 20,
                decoration: InputDecoration(
                    hintText: 'Create Report',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Current Month Collected :'),
                  SizedBox(width: 40,),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style:  TextStyle(fontSize: 14), // smaller text
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
