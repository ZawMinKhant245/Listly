import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isVisible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('assets/flag.png',height: 200,),
            const SizedBox(height:30,),
            TextFromFieldWidget(icons: Icon(Icons.person),text: 'Name',),
            const SizedBox(height: 20,),
            TextFromFieldWidget(icons: Icon(Icons.email),text: 'Email',),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurStyle: BlurStyle.outer,
                          blurRadius:10,
                          offset: Offset(1, 1)

                      )
                    ]
                ),
                child: TextFormField(
                  obscureText: isVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon:IconButton(onPressed: (){
                      setState(() {
                        isVisible = !isVisible;
                      });
                    }, icon:isVisible?Icon(Icons.visibility_off): Icon(Icons.visibility)) ,
                    border:InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 23),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurStyle: BlurStyle.outer,
                          blurRadius:10,
                          offset: Offset(1, 1)

                      )
                    ]
                ),
                child: TextFormField(
                  obscureText: isVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon:IconButton(onPressed: (){
                      setState(() {
                        isVisible = !isVisible;
                      });
                    }, icon:isVisible?Icon(Icons.visibility_off): Icon(Icons.visibility)) ,
                    border:InputBorder.none,
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(fontSize: 23),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text("Already Have Account"),
                TextButton(onPressed: (){}, child: Text('Sign In'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
