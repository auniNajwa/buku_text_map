import 'package:flutter/material.dart';

class FeaturesBoxWidget extends StatelessWidget {
  final IconButton icon;
  const FeaturesBoxWidget({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFA77D54),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(
                0,
                2,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: Colors.transparent,
          ),
        ),
        child: Center(
          child: icon.icon,
        ),
      ),
    );
  }
}
