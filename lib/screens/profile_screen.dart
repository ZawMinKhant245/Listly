import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access theme for consistent styling

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigo,
          elevation: 2,
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
                 child: Text('delete')),
           ],
             position: PopupMenuPosition.under,
             onSelected: (value){
                // dosomething
               if(value == 'logout'){

               }else{

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
                            height: 130, // Slightly reduced height
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                )),
                          ),
                          Positioned(
                            bottom: -50, // Adjusted for new avatar size
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 60, // Increased size for prominence
                                  backgroundColor: Colors.white, // Border color
                                  child: CircleAvatar(
                                    radius: 57,
                                    backgroundImage: NetworkImage(
                                        "https://thvnext.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=194&h=194&c=7&r=0&o=7&cb=ucfimgc2&pid=1.7&rm=3"),
                                  ),
                                ),
                                Positioned(
                                  // Positioned the edit button more cleanly
                                  bottom: 5,
                                  right: 5,
                                  child: Material(
                                    // Added Material for InkWell effect
                                    color: Colors.indigo,
                                    shape: CircleBorder(),
                                    elevation: 2,
                                    child: InkWell(
                                      onTap: () {
                                        // Handle edit profile picture
                                      },
                                      customBorder: CircleBorder(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(Icons.edit,
                                            size: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70), // Increased space for avatar
                      Center(
                        child: Text(
                          "Sai Naw Main",
                          // Removed "( Gay )" for a more professional look, can be added in a bio section
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          "ID - 34343",
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
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ProfileInfoTile(
                                  icon: Icons.email_outlined,
                                  title: "Email",
                                  subtitle: "sainawmain@example.com",
                                ),
                                Divider(height: 1, indent: 16, endIndent: 16),
                                ProfileInfoTile(
                                  icon: Icons.phone_outlined,
                                  title: "Phone",
                                  subtitle: "+95 9XX XXX XXXX",
                                ),
                                Divider(height: 1, indent: 16, endIndent: 16),
                                ProfileInfoTile(
                                  icon: Icons.location_on_outlined,
                                  title: "Address",
                                  subtitle: "Yangon, Myanmar",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // My Records Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "My Records",
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TableCalendar(
                          firstDay: DateTime.utc(2000, 1, 1),
                          lastDay: DateTime.utc(2100, 12, 31),
                          focusedDay: DateTime.now(),
                          calendarFormat: CalendarFormat.month,
                          selectedDayPredicate: (day) => isSameDay(day, DateTime.now()),
                          onDaySelected: (selectedDay, focusedDay) {
                            // TODO: handle date tap (maybe filter records?)
                            print("Selected: $selectedDay");
                          },
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
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Example: Replace with actual record data
                                      Text("Total Donation: 50 B",
                                          style: theme.textTheme.bodyLarge),
                                      const SizedBox(height: 8),
                                      Text("Last Donation Date: 2023-10-26",
                                          style: theme.textTheme.bodyLarge),
                                      const SizedBox(height: 8),
                                      // You could use a ListView.builder
                                    ]))),
                      )
                    ])));
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

