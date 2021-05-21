import 'package:flutter/material.dart';

class Appointment {
  String type;
  DateTime time;
  String date;

  Appointment(this.time, this.type, this.date);
}

class Appointments with ChangeNotifier {
  List availableTime = [
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '1 PM',
    '2 PM',
  ];

  List<Appointment> registered = [];

  void addAppointment(String type, DateTime time, String date) {
    registered.add(
      Appointment(time, type, date),
    );
  }

  List<Appointment> get resAppot {
    return [...registered];
  }

  List<DateTime> get apptDates {
    if (resAppot != null) {
      resAppot.forEach((element) {
        return element.time;
      });
    }
    return null;
  }
}
