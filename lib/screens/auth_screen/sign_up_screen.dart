import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listly/models/utilities.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:listly/screens/auth_screen/sign_in_screen.dart';
import 'package:provider/provider.dart';

import 'package:listly/models/user.dart' as AppUser;

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

  String mode='signIn';

  bool isLoading=false;

  Future<void>signUp()async{
    setState(() {
      isLoading = true;
    });
    try{
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      final userProvider=Provider.of<UserProvider>(context,listen: false);
      await userProvider.createUser(
          AppUser.User(
              id: userCredential.user!.uid,
              name: nameController.text.trim(),
              phone: phoneController.text.trim(),
              email: emailController.text.trim(),
              image: '',
              password: passwordController.text.trim(),
              idNumber: iDController.text.trim(),
              role: roleController.text.trim()
          )
      );
      showSuccessSnapBar(context, "SignUp Successfully.Please Signin");
      setState(() {
        mode = 'signIn';
      });
    }catch(e){
      debugPrint("Error SignUp $e");
      showErrorSnapBar(context, "SignUp Error $e");
    }
    setState(() {
      isLoading = false;
    });
  }

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
                SizedBox(height: 10,),
                Text("A revolution is not just an event, it’s a movement.",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height:20,),
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
                  child: isLoading?CircularProgressIndicator(color: Colors.teal,):ButtonWidget(text: 'Sign Up',onPress: (){
                    if(keys.currentState!.validate()){
                      signUp();
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
