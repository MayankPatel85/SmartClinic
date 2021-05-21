import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../providers/doctors.dart';
import '../screens/appointment_screen.dart';

class DoctorDetail extends StatelessWidget {
  static const routeName = '/doctor-detail';

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context).settings.arguments as String;
    final docdata = Provider.of<Doctors>(context)
        .docs
        .firstWhere((element) => element.name == name);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(15),
              color: Color(0xFFa8d8ea),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Text(
                      docdata.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: CircleAvatar(
                      child: SvgPicture.asset(
                        'assets/svg/doctor.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.white,
                            child: ListTile(
                              title:
                                  Text('Patients', textAlign: TextAlign.center),
                              subtitle: Text(
                                docdata.patients,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.amber),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.white,
                            child: ListTile(
                              title: Text('Experience',
                                  textAlign: TextAlign.center),
                              subtitle: Text(
                                docdata.experience,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.pinkAccent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              color: Color(0xFFff75a0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Doctor',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${docdata.name} is a Veteran Doctor and has a 5 star rating.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                //shadowColor: Colors.white,
                //clipBehavior: Clip.none,
                margin: EdgeInsets.all(10),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  //contentPadding: EdgeInsets.all(8),
                  title: Text(
                    'Clinic Address',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  subtitle: Text(
                    docdata.clinicAddr,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(Icons.location_city),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppointmentScreen.routeName,
                      arguments: docdata);
                },
                child: Text(
                  'Take Appointment',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
