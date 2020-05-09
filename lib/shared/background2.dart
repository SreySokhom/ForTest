import 'package:flutter/material.dart';

class Background2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(10.0, 60.0)
      ..lineTo(size.width, 50)
      ..lineTo(size.width, 5.0)
      ..close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

