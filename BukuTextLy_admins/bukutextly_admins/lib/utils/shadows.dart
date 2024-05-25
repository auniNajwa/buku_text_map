// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShadowStlye {
  static final verticalProductShadow = BoxShadow(
    color: Colors.grey,
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: Colors.grey,
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
