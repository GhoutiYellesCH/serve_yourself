import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serveyourself/components/mosaic.dart';
import 'package:serveyourself/components/myButton.dart';
import 'package:serveyourself/components/myTextField.dart';

import 'package:serveyourself/helpers/design.dart';
import 'package:serveyourself/helpers/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController(text: "tlemcen@algeria.com");
  final TextEditingController passwordController =
      TextEditingController(text: "Tlemcen@1234");

  bool _passwordVisible = false;

  String? passwordValidator(String? value) {
    final passwordPatternRules =
        r'^(?=.*[A-Z])(?=.*?[0-9])(?=.*?[ @#\&*~]).{8,}';
    final passwordRegExp = RegExp(passwordPatternRules);
    if (value == null || !passwordRegExp.hasMatch(value)) {
      return 'Password must have at least 8 characters,\n 1 uppercase letter, 1 number, and 1 special character';
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


  void Signup() async{
    if (_formKey.currentState!.validate()) {
      await _createAccount();
    }
  }

  // start
  Future<void> _createAccount() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Mise à jour du nom de l'utilisateur (facultatif)
      await userCredential.user?.updateDisplayName(emailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Account created successfully! Welcome ${emailController.text}')),
      );

      // Redirige l'utilisateur après l'inscription
      context.goNamed(Routes.routeLogin);
      ; // Redirige vers une page "home"
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
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

          MosaicBackground(),

          ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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


                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: MyButton(
                                onPressed: () {
                                  Signup();
                                },
                                text: Text(
                                  "Sign UP",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Design.primary)),
                        SizedBox(
                          height: 15,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: MyButton(
                          onPressed: () {
                            context.goNamed(Routes.routeLogin);
                          },
                          text: Text("Login",
                              style: TextStyle(color: Colors.white)),
                          color: Design.primary))
                ],
              ))
            ],
          ),
        ],
      ),
    ));
    // end
  }
}
