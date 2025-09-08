import 'package:flutter/material.dart';
import 'package:listly/screens/auth_screen/sign_up_screen.dart';
import 'package:listly/screens/main_screen.dart';

import '../widgets/widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool isVisible=true;
  final key=GlobalKey<FormState>();

  final emailController=TextEditingController();
  final passwordController=TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build body');
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height:20,),
                Image.asset('assets/flag.png',height: 200,),
                const SizedBox(height:30,),
                TextFromFieldWidget(
                  textEditingController: emailController,
                  icons: const Icon(Icons.email),
                  text: 'Email',),
                const SizedBox(height: 20,),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurStyle: BlurStyle.outer,
                            blurRadius:10,
                            offset: Offset(1, 1)
        
                        )
                      ]
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: isVisible,
                    validator: (text){
                      if( text == null || text.isEmpty ){
                        return 'Enter password';
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon:IconButton(
                          onPressed: (){
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
                  padding: const EdgeInsets.all(10),
                  child: ButtonWidget(text: 'Sign in',onPress: (){
                    if(key.currentState!.validate()){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_)=>MainScreen())
                      );
                    }else{
        
                    }
                  },),
                ),
                const SizedBox(height: 20,),
                TextButton(onPressed: (){}, child: Text('Forgot password?',style: TextStyle(fontSize: 20),)),
                const SizedBox(height: 20,),
                Text('Or',style: TextStyle(fontSize: 24),),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ButtonWidget(text: 'Sign Up',onPress: (){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_)=>SignUpScreen())
                    );
                  },),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




