import 'package:flutter/material.dart';
import 'package:buku_text_map/Utils/colors.dart';
import 'package:buku_text_map/Screen/forgot_password.dart';
import 'package:buku_text_map/Screen/view_dashboard.dart';
import 'package:buku_text_map/Screen/sign_up.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.03),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "Hello Again!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.08, // Responsive font size
                      color: textColor1,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Welcome back you've\nbeen missed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.06, // Responsive font size
                      color: textColor2,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  myTextField("Enter username", Colors.white, size),
                  SizedBox(height: 10),
                  myTextField("Password", Colors.black26, size, obscureText: true),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.04, // Responsive font size
                          color: textColor2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Dashboard screen when Sign In button is tapped
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    },
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.06, // Responsive font size
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialIcon("assets/images/google.png"),
                      SizedBox(width: 10),
                      socialIcon("assets/images/apple.png"),
                      SizedBox(width: 10),
                      socialIcon("assets/images/facebook.png"),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  GestureDetector(
                    onTap: () {
                      // Navigate to SignUp screen when "Register now" text is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Not a member? ",
                        style: TextStyle(
                          color: textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.04, // Responsive font size
                        ),
                        children: [
                          TextSpan(
                            text: "Register now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Image.asset(
        image,
        height: 35,
      ),
    );
  }

  Container myTextField(String hint, Color color, Size size, {bool obscureText = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 10),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: size.width * 0.045, // Responsive font size
          ),
          suffixIcon: Icon(
            Icons.visibility_off_outlined,
            color: color,
          ),
        ),
      ),
    );
  }
}
