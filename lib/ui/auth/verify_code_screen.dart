import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/ui/posts/post_screen.dart';
import 'package:firebase_demo/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {

  final String verificationId;

  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify Screen",
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
                    controller: codeController, // Connect the controller
                    decoration: const InputDecoration(
                      labelText: "Enter 6 Digit Code",
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Code";
                      } else if (value.length != 6) {
                        return "Code must be 6 digits";
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            RoundButton(
              title: "Verify",
              loading: loading,
              onTap: () async {

                if (_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });

                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: codeController.text.toString(),
                  );

                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
