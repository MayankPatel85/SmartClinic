import 'package:flutter/material.dart';

class Doctor with ChangeNotifier {
  String name;
  String type;
  String patients;
  String experience;
  String clinicAddr;

  Doctor(
      {this.name, this.type, this.patients, this.experience, this.clinicAddr});
}
