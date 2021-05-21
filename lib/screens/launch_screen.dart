import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/doctor_grid.dart';
import '../widgets/appdrawer.dart';

class LaunchScreen extends StatefulWidget {
  static const routeName = '/launch-screen';

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    _fetchUserName();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;

  String _username = '';

  Future<void> _fetchUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      setState(() {
        _username = value.data()['username'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3490de),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              child:
                  Image.asset('assets/icons/PowerPeople_Christopher03-1.png'),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: size.height * 0.17,
                  color: Color(0xFF3490de),
                ),
              ),
              ClipPath(
                clipper: CustomShape2(),
                child: Container(
                  height: size.height * 0.27,
                  color: Color(0xFF3490de).withOpacity(0.4),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: 200,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      _username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: DoctorGrid()),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 10);
    path.quadraticBezierTo(width / 3, height, width, height - 100);
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
