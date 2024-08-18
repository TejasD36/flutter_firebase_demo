import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/ui/auth/login_with_mobile_number.dart';
import 'package:firebase_demo/ui/auth/signup_screen.dart';
import 'package:firebase_demo/ui/posts/post_screen.dart';
import 'package:firebase_demo/utils/utils.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading=false;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){

    setState(() {
      loading=true;
    });

    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()
    ).then((value){
      setState(() {
        loading=false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
    }).onError((error,stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Screen",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
          backgroundColor: Colors.cyan,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
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
                title: "Log In",
                loading: loading,
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    login();
                  }
                },
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Don't have a Account? "),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=> const SignupScreen()
                          )
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> const LoginWithMobileNumber()
                        )
                    );
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                      child: Text(
                        "Login with Mobile Number",
                        style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
