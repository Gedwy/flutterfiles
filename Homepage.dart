import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

const List<Color> GrediantList = [
  Colors.deepOrangeAccent,
  Colors.orangeAccent,
  Colors.orange
];

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(begin: Alignment.topCenter, colors: GrediantList),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.signOut();
                      Navigator.of(context).pushReplacementNamed("loginPage");
                    },
                    child: Text("SignOut"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
