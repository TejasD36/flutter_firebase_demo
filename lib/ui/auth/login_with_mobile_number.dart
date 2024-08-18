import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/ui/auth/verify_code_screen.dart';
import 'package:firebase_demo/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class LoginWithMobileNumber extends StatefulWidget {
  const LoginWithMobileNumber({super.key});

  @override
  State<LoginWithMobileNumber> createState() => _LoginWithMobileNumberState();
}

class _LoginWithMobileNumberState extends State<LoginWithMobileNumber> {

  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool loading=false;

  verify(){

    setState(() {
      loading=true;
    });

    auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (_){
          setState(() {
            loading=false;
          });
        },
        verificationFailed: (e){
          setState(() {
            loading=false;
          });
          print("******************ERROR*****************");
          print(e.toString());
          print("******************ERROR*****************");
          Utils().toastMessage(e.toString());
        },
        codeSent: (String verificationId, int? token){
          setState(() {
            loading=false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>VerifyCodeScreen(
                    verificationId: verificationId,
                  )
              )
          );
        },
        codeAutoRetrievalTimeout: (e){
          setState(() {
            loading=false;
          });
          print("******************ERROR*****************");
          print(e.toString());
          print("******************ERROR*****************");
          Utils().toastMessage(e.toString());
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        toolbarHeight: 60,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: "Enter Phone Number",
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      prefixIconColor: Colors.cyan,
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Number";
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            RoundButton(
              title: "Log In",
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                  verify();
                }
              },
            ),
          ],
        ),
      ),

    );
  }
}
