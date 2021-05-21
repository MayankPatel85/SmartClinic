import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//import 'package:date_time_picker/date_time_picker.dart';

import './doctor_category.dart';
import './date_picker.dart';
//import '../providers/doctors.dart';

class DoctorGrid extends StatefulWidget {
  @override
  _DoctorGridState createState() => _DoctorGridState();
}

class _DoctorGridState extends State<DoctorGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        children: [
          DatePicker(),
          // DateTimePicker(
          //   type: DateTimePickerType.dateTimeSeparate,
          //   initialValue: DateTime.now().toString(),
          //   firstDate: DateTime(2020),
          //   lastDate: DateTime.now(),
          // ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Find your doctor',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(height: 120, child: DoctorCategory()),
        ],
      ),
    );
  }
}
