import 'package:flutter/material.dart';
import 'package:listly/screens/auth_screen/sign_up_screen.dart';

import '../widgets/widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool isVisible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('assets/flag.png',height: 200,),
            const SizedBox(height:30,),
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
            Row(
              children: [
                Text("Don't Have Account Yet?"),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_)=>SignUpScreen())
                  );
                }, child: Text('Sign Up'))
              ],
            )
          ],
        ),
      ),
    );
  }
}


