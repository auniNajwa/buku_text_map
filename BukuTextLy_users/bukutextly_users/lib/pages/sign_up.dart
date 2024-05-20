import 'package:bukutextly_users/components/my_button.dart';
import 'package:bukutextly_users/components/my_textfield.dart';
import 'package:bukutextly_users/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
//text editing controllers
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up method
  Future signUserUp() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    //authenticate
    if (passwordConfirmed()) {
      try {
        //create new user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        //create a new document after creating the new user
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set(
          {
            'username': usernameController.text.trim(), //initial username
            'first_name': firstNameController.text.trim(), //initial first name,
            'last_name': lastNameController.text.trim(), //initial last name,
            'bio': 'Empty Bio . . .' //initially empty bio
            // can add more field here
          },
        );
      } on FirebaseAuthException catch (e) {
        //show error to user
        displayMessageToUser(e.code, context);
      }

      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      _showPasswordWrongDialog(context);
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void _showPasswordWrongDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Password does not match',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          content: Text('Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF885A3A),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),

                Container(
                  child: Image.asset(
                    'assets/logos/blacklogo.png',
                    height: 150,
                  ),
                ),

                //Username Text Field
                SizedBox(height: 25),
                MyTextfield(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                //first name Text Field
                SizedBox(height: 10),
                MyTextfield(
                  controller: firstNameController,
                  hintText: 'First name',
                  obscureText: false,
                ),

                //last name Text Field
                SizedBox(height: 10),
                MyTextfield(
                  controller: lastNameController,
                  hintText: 'Last name',
                  obscureText: false,
                ),

                //Email Text Field
                SizedBox(height: 10),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                //Password Text Field
                SizedBox(height: 10),
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: 10),
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                //Sign Up button
                SizedBox(height: 25),
                MyButton(
                  textInButton: "Sign Up",
                  onTap: signUserUp,
                ),

                //or continue with
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                //already got acc? sign in
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
