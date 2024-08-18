import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/utils/utils.dart';
import 'package:firebase_demo/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {

  final databaseReference = FirebaseDatabase.instance.ref("Post");
  final auth=FirebaseAuth.instance;
  bool loading=false;
  final _formKey = GlobalKey<FormState>();
  final postController = TextEditingController();


  addPost(){

    setState(() {
      loading=true;
    });

    // databaseReference.child(DateTime.now().microsecondsSinceEpoch.toString()).child("Comments").set({

    databaseReference.child(DateTime.now().microsecondsSinceEpoch.toString()).set({

      'title':postController.text.toString(),
      'id':DateTime.now().microsecondsSinceEpoch.toString(),

    }).then((value){
      setState(() {
        loading=false;
      });
    }).onError((error,stackTrace){
      setState(() {
        loading=true;
      });
      Utils().toastMessage(error.toString());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Post",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              key: _formKey,
              maxLines: 10,
              controller: postController,
              decoration: const InputDecoration(
                labelText: 'Write a post',
                labelStyle: TextStyle(color: Colors.cyanAccent),
                border: OutlineInputBorder(),
              ),

              validator: (value){
                if(value!.isEmpty){
                  return "Enter Email";
                }
                return null;
              },
            ),
            const SizedBox(height: 30,),
            RoundButton(
                title: "Add Post",
                loading: loading,
                onTap: (){
                  addPost();
                }
            )
          ],
        ),
      ),
    );
  }
}
