import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 10);
    // path.quadraticBezierTo(width / 3, height, width, height - 100);
    path.cubicTo(
        width / 4, height, 3 * width / 4, height / 4, width, height * 0.8);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomShape2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height * 0.80);
    path.cubicTo(
        width / 4, height, 3 * width / 4, height / 2, width, height * 0.8);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomShape3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.moveTo(0, height);
    path.lineTo(0, height * 0.40);
    path.cubicTo(
        width / 4, height, 3 * width / 4, height / 6, width, height * 0.15);
    path.lineTo(width, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
