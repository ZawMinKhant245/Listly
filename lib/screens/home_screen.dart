import 'package:flutter/material.dart';

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
            Text("50000B",style: TextStyle(fontWeight: FontWeight.bold),)
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
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurStyle: BlurStyle.outer,
                          blurRadius:5,
                          offset: Offset(1,1)

                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Colleted this month",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                    SizedBox(height: 5,),
                    Text("B 1,2344",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
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
                  height: 300,
                  width: double.infinity,
                  color: Colors.grey,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context,index){
                        return ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('Name'),
                          subtitle: Text('ID number'),
                        );
                      }
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
