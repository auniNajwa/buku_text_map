import 'package:flutter/material.dart';

class ItemSquare extends StatelessWidget {
  final String textInSquare;
  final IconData iconData;
  final Color textColor;

  const ItemSquare({
    super.key,
    required this.textInSquare,
    required this.iconData,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 100,
        width: 50,
        color: Colors.grey[400],
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                bottom: 25.0,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  iconData,
                  color: Colors.red, // Change color as needed
                  size: 25, // Change size as needed
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 10.0,
                ),
                child: Text(
                  textInSquare,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12, // Change size as needed
                    fontWeight: FontWeight.bold, // Change weight as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
