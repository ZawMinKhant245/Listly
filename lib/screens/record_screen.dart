import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
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
