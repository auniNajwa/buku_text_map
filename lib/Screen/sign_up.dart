import 'package:flutter/material.dart';
import 'package:buku_text_map/Utils/colors.dart';
import 'package:buku_text_map/Screen/sign_in.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [backgroundColor2, backgroundColor2, backgroundColor4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back button aligned to the left
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 40), // Adjust as needed for spacing
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "BukuText.ly",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: textColor2,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  inputFile(label: "Username"),
                  SizedBox(height: 10),
                  inputFile(label: "Email"),
                  SizedBox(height: 10),
                  inputFile(label: "Password", obscureText: true),
                  SizedBox(height: 10),
                  inputFile(label: "Confirm Password", obscureText: true),
                  SizedBox(height: size.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Dashboard screen when Sign Up button is tapped
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to sign in page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputFile({required String label, bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        myTextField(label, obscureText),
        SizedBox(height: 10),
      ],
    );
  }

  Widget myTextField(String hint, bool obscureText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: 14,
          ),
          suffixIcon: hint == "Password" || hint == "Confirm Password"
              ? Icon(
            Icons.visibility_off_outlined,
            color: Colors.black26,
          )
              : null,
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
}
