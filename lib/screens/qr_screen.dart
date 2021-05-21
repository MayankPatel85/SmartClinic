import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QrScreen extends StatelessWidget {
  static const routeName = '/qr-screen';
  @override
  Widget build(BuildContext context) {
    final url =
        'https://firebasestorage.googleapis.com/v0/b/smartclinic-9ac4c.appspot.com/o/Patient_ID2.pdf?alt=media';

    void _launchurl() async {
      await canLaunch(url) ? launch(url) : throw 'Could not launch';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My QR'),
        textTheme:
            TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Color(0xFF3490de),
      ),
      body: Column(
        children: [
          Image.asset('assets/qr/PHOTO-2021-05-08-23-36-28.jpg'),
          Spacer(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFF3490de),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton(
              child: Text(
                'Scan',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: _launchurl,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
