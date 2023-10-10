import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/resgister_view.dart';
import 'package:scholar_chat/widgets/custom_buttons.dart';
import 'package:scholar_chat/widgets/input_field.dart';

import '../components/show_snack_bar.dart';
import '../constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static String id = 'login screen id';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Container(
                margin: const EdgeInsets.only(top: 120),
                child: Image.asset(
                  kLogoPath,
                  height: 100,
                ),
              ),
              const Text(
                'Scholar Chat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              InputField(
                hint: 'Enter Your Email',
                label: 'Email',
                onChanged: (value) {
                  email = value;
                },
              ),
              InputField(
                isPassword: true,
                hint: 'Enter Your Password',
                label: 'Password',
                onChanged: (value) {
                  password = value;
                },
              ),
              LoginButton(
                text: 'Sign In',
                onPressed: () async {
                  loginUser(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'don\'t have an account ? ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RegisterView.id,
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  loginUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        // This block should execute if login is successful.

        setState(() {
          isLoading = false;
        });

        Navigator.pushNamed(
          context,
          ChatView.id,
          arguments: email,
        );
      //  print(email); 
      } on FirebaseAuthException catch (e) {
        // This block should execute if there is a FirebaseAuthException.
       // print('FirebaseAuthException: ${e.code}');
        if (e.code == 'user-not-found') {
          showSnackBar('No user found for that email.', context);
        } else if (e.code == 'wrong-password') {
          showSnackBar('Wrong password provided for that user.', context);
        } else {
          showSnackBar(e.message!, context);
        }
      } catch (e) {
        // This block should execute if there is any other error.
        //print('Error: $e');
        showSnackBar(e.toString(), context);
      }

      setState(() {
        isLoading = false;
      });
    } else {
      // This block should execute if form validation fails.
      showSnackBar('Validation Error', context);
    }
  }
}
