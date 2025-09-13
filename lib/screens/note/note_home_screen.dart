import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listly/models/note.dart';
import 'package:listly/provider/note_provider.dart';
import 'package:listly/screens/note/note_add_screen.dart';
import 'package:provider/provider.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {

  Widget buildNoteCard(Note note,int index){
    return InkWell(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteAddScreen(note: note,))),
      onLongPress: (){},
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                note.title,
                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
               Text(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                note.content,
                style: TextStyle(fontSize: 15,),),
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
    return Scaffold(
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
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,mainAxisSpacing: 10,crossAxisSpacing: 10
                  ),
                  itemBuilder: (context,index){
                    return buildNoteCard(notes[index], index);
                  },
                itemCount: notes.length,
              ),
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteAddScreen())),child: Icon(Icons.add),
      ),
    );
  }
}
