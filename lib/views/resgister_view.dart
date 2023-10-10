import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';

import '../components/show_snack_bar.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_field.dart';
import 'chat_view.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  static String id = 'register id';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                'Resgiter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              InputField(
                hint: 'Enter Your Email',
                label: 'Email',
                onChanged: (data) {
                  email = data;
                },
              ),
              InputField(
                isPassword: true,
                hint: 'Enter Your Password',
                label: 'Password',
                onChanged: (data) {
                  password = data;
                },
              ),
              LoginButton(
                text: 'Sign Up',
                onPressed: () async {
                  registration(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You already have an account ? ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  registration(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        setState(() {
          isLoading = false;
        });

        Navigator.pushNamed(
          context,
          ChatView.id,
          arguments: email,
        );
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'weak-password') {
          showSnackBar('The Password Provided is Too Weak', context);
        } else if (ex.code == 'email-already-in-use') {
          showSnackBar('The account already exists for that email.', context);
        } else if (ex.code == 'invalid-email') {
          showSnackBar('invalid email form ', context);
        }
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      showSnackBar('No validation ', context);
    }
  }
}
