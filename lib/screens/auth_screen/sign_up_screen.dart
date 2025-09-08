import 'package:flutter/material.dart';
import 'package:listly/screens/auth_screen/sign_in_screen.dart';

import '../widgets/widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final iDController=TextEditingController();
  final roleController=TextEditingController();

  bool isVisible=true;
  bool isVisible1=true;

  final keys =GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    iDController.dispose();
    roleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: keys,
            child: Column(
              children: [
                const SizedBox(height:20,),
                Image.asset('assets/flag.png',height: 200,),
                const SizedBox(height:30,),
                TextFromFieldWidget(
                  textEditingController: nameController,
                  icons: Icon(Icons.person),text: 'Name',),
                const SizedBox(height: 20,),
                TextFromFieldWidget(textEditingController:emailController,icons: Icon(Icons.email),text: 'Email',),
                const SizedBox(height: 20,),
                TextFromFieldWidget(textEditingController:iDController,icons: Icon(Icons.numbers),text: 'ID number',),
                const SizedBox(height: 20,),
                TextFromFieldWidget(textEditingController:phoneController,icons: Icon(Icons.phone),text: 'Phone Number',),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
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
                      controller: passwordController,
                      obscureText: isVisible,
                      validator: (text){
                        if( text == null || text.isEmpty ){
                          return 'Please Enter password';
                        }else if(text != confirmPasswordController.text){
                          return 'password not match';
                        }else{
                          return null;
                        }
                      },
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
                      obscureText: isVisible1,
                      controller: confirmPasswordController,
                      validator: (text){
                        if( text == null || text.isEmpty ){
                          return 'Please Enter password';
                        }else if(text != passwordController.text){
                          return 'password not match';
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon:IconButton(onPressed: (){
                          setState(() {
                            isVisible1 = !isVisible1;
                          });
                        }, icon:isVisible1?Icon(Icons.visibility_off): Icon(Icons.visibility)) ,
                        border:InputBorder.none,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(fontSize: 23),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFromFieldWidget(textEditingController:roleController,icons: Icon(Icons.account_circle),text: 'Role',),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ButtonWidget(text: 'Sign Up',onPress: (){
                    if(keys.currentState!.validate()){

                    }else{

                    }
                  },),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have Account!!"),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>SignInScreen()));
                    }, child: Text('Sign In'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
