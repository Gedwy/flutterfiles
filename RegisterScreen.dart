import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/CustomBtn.dart';
import 'package:firebase_app/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

const List<Color> GrediantList = [
  Colors.deepOrangeAccent,
  Colors.orangeAccent,
  Colors.orange
];

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _Registerscreen();
}

class _Registerscreen extends State<Registerscreen> {
  GlobalKey<FormState> myFormGlobalKey = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nuuuul = TextEditingController();

  createUserWithEmailAndPassword() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Navigator.of(context).pushReplacementNamed("loginPage");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'weak-password',
        )..show();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Dialog Title',
          desc: 'The account already exists for that email',
        )..show();
        print('The account already exists for that email.');
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'The email address is badly formatted',
        )..show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: '$e',
      )..show();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        // Main Container for colors
        Container(
          height: 800,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, colors: GrediantList),
          ),
          child: Column(
            // Main Cloumn
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(100),
              Padding(
                padding: const EdgeInsets.all(20.0),
                // Column for Register and create an account
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40),
                    ),
                    Gap(5),
                    Text(
                      "Create An Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
              Gap(40),
              // Expanded for Text Field
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Gap(70),
                      // Main Container for text field decoration
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, 0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                        // Mail Cloumn for Text fields
                        child: Form(
                          key: myFormGlobalKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  mycontroller: nuuuul,
                                  inputText: "Name",
                                  securePass: false,
                                  underline: true),
                              CustomTextField(
                                  mycontroller: usernameController,
                                  inputText: "Email",
                                  securePass: false,
                                  underline: true),
                              CustomTextField(
                                  mycontroller: passwordController,
                                  inputText: "password",
                                  securePass: true,
                                  underline: true),
                            ],
                          ),
                        ),
                      ),
                      Gap(50),
                      CustomBtn(
                          onTap: () {
                            createUserWithEmailAndPassword();
                          },
                          inputText: "Register",
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white),
                      Gap(20),
                      CustomBtn(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed("loginPage");
                          },
                          inputText: "Cancel",
                          backgroundColor: Colors.red,
                          textColor: Colors.white)
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ],
    ));
  }
}
