import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/doctor_detail_screen.dart';

class DoctorsPreview extends StatelessWidget {
  @required
  final String name;
  @required
  final String type;
  final String address;
  //String imageUrl;
  DoctorsPreview({this.name, this.type, this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      color: Color(0xFFa8d8ea),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          title: Column(
            children: [
              Text(name),
              SizedBox(height: 10),
              Text(address),
            ],
          ),
          leading: CircleAvatar(
            child: SvgPicture.asset(
              'assets/svg/doctor.svg',
              fit: BoxFit.contain,
            ),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [IconButton(icon: Icon(Icons.call), onPressed: null)],
            ),
          ),
          onTap: () => Navigator.of(context)
              .pushNamed(DoctorDetail.routeName, arguments: name),
        ),
      ),
    );
  }
}
