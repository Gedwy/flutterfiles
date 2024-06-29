import 'package:firebase_app/Homepage.dart';
import 'package:firebase_app/LoginPage.dart';
import 'package:firebase_app/RegisterScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDbM1Tw2hStnEDeDyOFAwTQolHp_KfW_Lc",
          appId: "1:856139397042:android:c358b3acd1b1b6c41316ab",
          messagingSenderId: "856139397042",
          projectId: "fluttercourse-6ff3d"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('============================User is currently signed out!');
      } else {
        print('==========================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Roboto_Slab"),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? Homepage()
          : LogInPage(),
      routes: {
        "loginPage": (context) => LogInPage(),
        "registerScreen": (context) => Registerscreen(),
        "homePage": (context) => Homepage()
      },
    );
  }
}
