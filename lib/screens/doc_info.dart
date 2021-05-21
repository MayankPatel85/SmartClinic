import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/doctors.dart';
import '../widgets/doctors_preview.dart';

class DocInfo extends StatelessWidget {
  static const routeName = '/doc-info';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final docType = ModalRoute.of(context).settings.arguments as String;
    final docData = Provider.of<Doctors>(context).findByType(docType);
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
        textTheme:
            TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Color(0xFF3490de),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: size.height * 0.08,
              color: Color(0xFF3490de),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemCount: docData.length,
                itemBuilder: (_, i) => DoctorsPreview(
                  name: docData[i].name,
                  type: docData[i].type,
                  address: docData[i].clinicAddr,
                ),
              ),
            ),
          ),
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
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
