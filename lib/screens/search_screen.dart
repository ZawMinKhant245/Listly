import 'package:flutter/material.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:provider/provider.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                height: 40,
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  onChanged: (value){
                    searchController.text=value;
                  },
                  decoration: InputDecoration(
                    label: Text('Name'),
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
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 600,
                child: Consumer<UserProvider>(
                  builder: (context, data, child) {
                    final query = searchController.text.trim();
                    final me=data.me;
                    final users = query.isEmpty
                        ? data.users.where((u)=>u.role.toLowerCase() != 'admin').toList()// show all users when no input
                        : data.users.where((u) =>
                        u.name.contains(query) // 🔍 filter by phone
                    ).toList();

                    if (users.isEmpty) {
                      return const Center(child: Text("No user found"));
                    }

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // adjust grid
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final isSelected=user.isSelected;
                        return InkWell(
                          onTap:(me != null && me.role=='Admin') ? () async {
                            final newValue = !isSelected;
                            await Provider.of<UserProvider>(context, listen: false)
                                .updateUserById(user.id, {"isSelected": newValue});
                          }:null,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected?Colors.green:Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${user.name}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text("Phone: ${user.phone}"),
                                Text("Role: ${user.role}"),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

              ),
            ],
          ),
        ),
      )
    );
  }
}
