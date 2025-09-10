import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final searchController=TextEditingController();
  bool _showSuffixIcon = false;

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {
        _showSuffixIcon = searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextFormField(
                controller: searchController,
                keyboardType: TextInputType.phone,
                onChanged: (value){
                  searchController.text=value;
                },
                decoration: InputDecoration(
                  label: Text('Phone Number'),
                  border: OutlineInputBorder(),
                  suffixIcon: _showSuffixIcon?
                  IconButton(
                      onPressed: (){
                        setState(() {
                          searchController.clear();
                        });
                      },
                      icon: Icon(Icons.clear_rounded)
                  ):null
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
