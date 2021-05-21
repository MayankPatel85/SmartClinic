import 'package:flutter/material.dart';
import 'package:smartclinic/widgets/clippers.dart';

class AuthBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: size.height * 0.34,
                  color: Color(0xFF3490de),
                ),
              ),
              ClipPath(
                clipper: CustomShape2(),
                child: Container(
                  height: size.height * 0.47,
                  color: Color(0xFF3490de).withOpacity(0.4),
                ),
              ),
            ],
          ),
          Spacer(
            flex: 2,
          ),
          ClipPath(
            clipper: CustomShape3(),
            child: Container(
              height: size.height * 0.47,
              color: Color(0xFF3490de),
            ),
          ),
        ],
      ),
    );
  }
}
