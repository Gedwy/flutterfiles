import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/CustomBtn.dart';
import 'package:firebase_app/CustomTextField.dart';
import 'package:firebase_app/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

const List<Color> GrediantList = [
  Colors.deepOrangeAccent,
  Colors.orangeAccent,
  Colors.orange
];

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  GlobalKey<FormState> myFormGlobalKey = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nuuuul = TextEditingController();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleUser == null) {
      return null;
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).pushReplacementNamed("homePage");
  }

  signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'user-not-found',
        )..show();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'Wrong password provided for that user',
        )..show();
        print('Wrong password provided for that user.');
      }
    }
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified) {
      Navigator.of(context).popAndPushNamed("homePage");
    } else if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'Please Verify Your Email',
      )..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // home Container
      body: ListView(
        children: [
          Container(
            height: 800,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: GrediantList,
              ),
            ),
            // Column Home Containter
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(100),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  // Login Text Column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Gap(5),
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Gap(40),
                // Expanded for the field and login btn
                Expanded(
                  // Container for decoration the box shadow
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      // Column for the field and login btn
                      child: Column(
                        children: [
                          Gap(70),
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, 0.3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                            // Column for Text Field
                            child: Form(
                              key: myFormGlobalKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    mycontroller: usernameController,
                                    inputText: "Username Or Phone",
                                    securePass: false,
                                    underline: true,
                                  ),
                                  CustomTextField(
                                    mycontroller: passwordController,
                                    inputText: "Password",
                                    securePass: true,
                                    underline: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forget Password ?",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ],
                          ),
                          Gap(15),
                          CustomBtn(
                              onTap: () async {
                                await signInWithEmailAndPassword();
                              },
                              inputText: "Login",
                              backgroundColor: Colors.deepOrangeAccent,
                              textColor: Colors.white),
                          Gap(20),
                          CustomBtn(
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            inputText: "Login With Google",
                            onTap: () async {
                              await signInWithGoogle();
                            },
                          ),
                          Gap(20),
                          CustomBtn(
                            inputText: "Register",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("registerScreen");
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
