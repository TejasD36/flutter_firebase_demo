import 'package:firebase_demo/ui/auth/login_screen.dart';
import 'package:firebase_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/round_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool loading=false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp(){
    setState(() {
      loading=true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()
    ).then((value){
      setState(() {
        loading=false;
      });
    }).onError((error,stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Screen",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.cyan,
        toolbarHeight: 60,
        automaticallyImplyLeading: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      prefixIconColor: Colors.cyan,
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      prefixIconColor: Colors.cyan,
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            RoundButton(
              title: "Sign Up",
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                  signUp();
                }
              },
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Already have an Account? "),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> const LoginScreen()
                        )
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
