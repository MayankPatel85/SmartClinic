import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Smart',
              style: TextStyle(
                  color: Color(0xFF3490de),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              'Clinic',
              style: TextStyle(
                  color: Color(0xFF3490de),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
