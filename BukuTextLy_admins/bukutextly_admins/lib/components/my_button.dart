import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String textInButton;
  final Function()? onTap;

  const MyButton({
    super.key,
    required this.onTap,
    required this.textInButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: const Color(0xFF885A3A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              textInButton,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
