import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serveyourself/components/mosaic.dart';
import 'package:serveyourself/components/myButton.dart';
import 'package:serveyourself/components/myTextField.dart';
import 'package:serveyourself/helpers/design.dart';
import 'package:serveyourself/helpers/routes.dart';

import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController =

      TextEditingController(text: "azizi062004@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "aziziM0@azizi");


  bool _passwordVisible = false;

  String? passwordValidator(String? value) {
    final passwordPatternRules =
        r'^(?=.*[A-Z])(?=.*?[0-9])(?=.*?[ @#\&*~]).{8,}';
    final passwordRegExp = RegExp(passwordPatternRules);
    if (value == null || !passwordRegExp.hasMatch(value)) {
      return 'Password must have at least 8 c 	  haracters,\n 1 uppercase letter, 1 number, and 1 special character';
    }
    return null;
  }

  String? emailValidator(String? value) {
    final emailPatternRules =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final emailRegExp = RegExp(emailPatternRules);
    if (value == null || !emailRegExp.hasMatch(value)) {
      return 'wrong email format ';
    }
    return null;
  }


  void login()async {

    if (_formKey.currentState!.validate()) {
                                print("Email: ${emailController.text}");
                                print("Password: ${passwordController.text}");

                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'email', emailController.text);
                                  print("Email Stored");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Login successful!')),
                                  );
                                  context.goNamed(Routes.routeHome);
                                } on FirebaseAuthException catch (e) {
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('invalid-email or password')),
                                  );

                                  if (e.code == 'invalid-email') {
                                    print('Invalid Email');
                                  } else if (e.code == 'invalid-credential') {
                                    print('user-not-found OR Wrong Password');
                                  } else {
                                    print(
                                        'Failed to login with error code: ${e.code}, ${e.message}');
                                  }
                                }
                                
                              }
  

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Design.surface2,
      body: Stack(
        children: [
          MosaicBackground(),
          ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                 width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                
                     Text(
                        "Serve\nYourself",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Design.primary,
                            fontSize: (40)),
                            
                      ),
                    
                  ],
                ),
              )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextField(
                          icon: Icon(
                            Icons.email,
                            color: Design.primary,
                          ),
                          isVisible: true,
                          controller: emailController,
                          validator: emailValidator,
                          label: "email",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          icon: Icon(
                            Icons.lock,
                            color: Design.primary,
                          ),
                          isVisible: false,
                          controller: passwordController,
                          validator: passwordValidator,
                          label: "password",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: MyButton(
                                onPressed: () {
                                  login();
                                },
                                text: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Design.primary)),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: MyButton(
                              onPressed: () {},
                              text: Text(
                                "Forgot your password ?",
                                style: TextStyle(color: Design.textColor),
                              ),
                              color: Design.surface2),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: MyButton(
                          onPressed: () {
                            context.goNamed(Routes.routeSignUp);
                          },
                          text: Text("SignUp",
                              style: TextStyle(color: Colors.white)),
                          color: Design.primary))
                ],
              ))
            ],
          ),
        ],
      ),
    ));
  }
}
