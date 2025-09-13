import 'package:flutter/material.dart';
import 'package:listly/screens/note/note_add_screen.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,mainAxisSpacing: 10,crossAxisSpacing: 10
            ),
            itemBuilder: (context,index){
              return InkWell(
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteAddScreen())),
                splashColor: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  color: Colors.indigo.shade100,
                  elevation: 6,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          'Something Title of Anyone Mind',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          'Something Title of Anyone Mind Something Title of Anyone Mind',
                          style: TextStyle(fontSize: 15,),),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          '01/04/2025',
                          style: TextStyle(fontWeight: FontWeight.bold,),
                        ),


                      ],
                    ),
                  ),
                ),
              );
                
                Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
                ),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NoteAddScreen())),child: Icon(Icons.add),
      ),
    );
  }
}
