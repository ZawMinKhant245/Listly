import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/widgets/widget.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:listly/provider/auth_provider.dart ' as AP;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Future<String?> pickAndUploadImageToImgbb() async {
    try {
      // Step 1: Pick image
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return null;

      // Step 2: Read image as bytes
      final bytes = await File(pickedImage.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      // Step 3: Upload to ImgBB
      const apiKey = 'db3cabe2e2f148b81cb4be0675beaa3f';
      final url = Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey');

      final response = await http.post(
        url,
        body: {
          'image': base64Image,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imageUrl = data['data']['url'] as String;
        return imageUrl;
      } else {
        print('ImgBB upload failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Future showDialogTitle(BuildContext context,String title,String bodyText,String firstText,String secondText,VoidCallback onPressed){
    return showDialog(
        context: context,
        builder: (context){
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5,),
                  Text(title,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700),),
                  SizedBox(height: 20,),
                  Text(bodyText,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: onPressed,
                          child: Text(firstText),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: ()=> Navigator.of(context).pop(),
                        child: Text(secondText),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
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
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access theme for consistent styling
    return FutureBuilder(
        future: Provider.of<UserProvider>(context,listen: false).getUserById(FirebaseAuth.instance.currentUser!.uid),
        builder: (context,snapShoot){
          if(snapShoot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: Center(
                child:CircularProgressIndicator(color: Colors.teal,),
              ),
            );
          }else{
            return Consumer<UserProvider>(
                builder: (context,data,child){
                  bool isDonated=data.me!.isSelected;
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.indigo,
                    title: Text(
                      "Profile",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                    iconTheme: IconThemeData(color: Colors.white),
                    // For back button if any
                    actions: [
                      PopupMenuButton(itemBuilder: (context)=>[
                        PopupMenuItem(
                          value: 'logout',
                          child: Text('Log out'),
                        ),
                        PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete Account')),
                      ],
                        position: PopupMenuPosition.under,
                        onSelected: (value){
                          // dosomething
                          if(value == 'logout'){
                            showDialogTitle(context,'Alert Dialog','Are you sure want to log out?','confirm','cancel',() async {
                              await FirebaseAuth.instance.signOut();
                              Provider.of<AP.AuthProvider>(context,listen: false).clearUser();
                              Navigator.of(context).pop();
                            });
                          }else{
                            showDialogTitle(context,'Alert Dialog','Are you sure want to  DELETE account?','confirm','cancel',() async {
                              Provider.of<UserProvider>(context,listen: false).deleteUserById(FirebaseAuth.instance.currentUser!.uid);
                            });

                          }
                        },
                      )
                    ],
                  ),
                  body: SingleChildScrollView(// Added overall padding
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 400, // Slightly reduced height
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      image: DecorationImage(
                                          image: AssetImage('assets/grouplogo.png'),
                                        fit: BoxFit.cover
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      )),
                                ),
                                Positioned(
                                  bottom: -60,
                                  child: InkWell(
                                    onTap:()async{
                                      // Handle edit profile picture
                                      final image=await pickAndUploadImageToImgbb();
                                      if(image != null){
                                        await Provider.of<UserProvider>(context,listen: false)
                                            .updateUserById(data.me!.id, {"image":image});
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 60, // Increased size for prominence
                                      backgroundColor: Colors.white, // Border color
                                      child: CircleAvatar(
                                        radius: 57,
                                        backgroundImage: data.me!.image.isEmpty? NetworkImage(
                                            "https://th.bing.com/th?q=Grey+Person+Icon&w=120&h=120&c=1&rs=1&qlt=90&r=0&cb=1&pid=InlineBlock&mkt=en-WW&cc=TH&setlang=en&adlt=strict&t=1&mw=247")
                                        :NetworkImage(data.me!.image),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 70), // Increased space for avatar
                            Center(
                              child: Text(
                                data.me!.name,
                                style: theme.textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: Text(
                                "ID - ${data.me!.idNumber}",
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(color: Colors.grey[700]),
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Personal Information Section
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "Personal Information",
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ProfileInfoTile(
                                        icon: Icons.email_outlined,
                                        title: "Email",
                                        subtitle: data.me!.email,
                                      ),
                                      const Divider(height: 1, indent: 16, endIndent: 16),
                                       ProfileInfoTile(
                                        icon: Icons.phone_outlined,
                                        title: "Phone",
                                        subtitle:data.me!.phone,
                                      ),
                                      const Divider(height: 1, indent: 16, endIndent: 16),
                                       ProfileInfoTile(
                                        icon: Icons.person_2,
                                        title: "Role",
                                        subtitle: data.me!.role,
                                      ),
                                      if(data.me!.role != "Admin")...[
                                        Container(
                                          height: 40,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: isDonated?Colors.green:Colors.red,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child:isDonated?const Center(child: Text("Current Month Donated")):const Center(child: Text("You are not Donate Yet")),
                                        )
                                      ]

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // const SizedBox(height: 30),
                            // // My Records Section
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8),
                            //   child: Text(
                            //     "My Records",
                            //     style: theme.textTheme.titleLarge
                            //         ?.copyWith(fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8),
                            //   child: TableCalendar(
                            //     firstDay: DateTime.utc(2000, 1, 1),
                            //     lastDay: DateTime.utc(2100, 12, 31),
                            //     focusedDay: DateTime.now(),
                            //     calendarFormat: CalendarFormat.month,
                            //     selectedDayPredicate: (day) => isSameDay(day, DateTime.now()),
                            //     onDaySelected: (selectedDay, focusedDay) {
                            //       // TODO: handle date tap (maybe filter records?)
                            //       print("Selected: $selectedDay");
                            //     },
                            //   ),
                            // ),
                            // const SizedBox(height: 10),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8),
                            //   child: Card(
                            //       elevation: 2,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(12)),
                            //       child: Padding(
                            //           padding: const EdgeInsets.all(16.0),
                            //           child: Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 // Example: Replace with actual record data
                            //                 Text("Total Donation: 50 B",
                            //                     style: theme.textTheme.bodyLarge),
                            //                 const SizedBox(height: 8),
                            //                 Text("Last Donation Date: 2023-10-26",
                            //                     style: theme.textTheme.bodyLarge),
                            //                 const SizedBox(height: 8),
                            //                 // You could use a ListView.builder
                            //               ]))),
                            // )
                          ])));
            });
          }
        }
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ProfileInfoTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: Colors.indigo[400]),
      // Consistent icon color
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

