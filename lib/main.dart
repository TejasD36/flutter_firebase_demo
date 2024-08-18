import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/ui/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';


import 'firebase_options.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runZonedGuarded(() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     runApp(const MyApp());
//   }, (error, stackTrace) {
//     print(error);
//   });
// }

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  // Initialize Firebase App Check
  // await FirebaseAppCheck.instance.activate();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
