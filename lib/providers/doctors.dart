import 'package:flutter/material.dart';
//import 'dart:convert';

import './doctor.dart';

class Doctors with ChangeNotifier {
  List<Doctor> _docs = [
    Doctor(
        name: 'Dr. Kajal Patel',
        type: 'Dental',
        patients: '250+',
        experience: '5 years',
        clinicAddr: 'Piplod,Surat.'),
    Doctor(
        name: 'Dr. Parthiv Mehta',
        type: 'Dental',
        patients: '250+',
        experience: '5 years',
        clinicAddr: 'Piplod,Surat.'),
    Doctor(
        name: 'Dr. Priya Jariwala',
        type: 'Dental',
        patients: '250+',
        experience: '5 years',
        clinicAddr: 'Piplod,Surat.'),
    Doctor(
        name: 'Dr. Akshay Tailor',
        type: 'Dental',
        patients: '250+',
        experience: '5 years',
        clinicAddr: 'Piplod,Surat.'),
    Doctor(
        name: 'bcd',
        type: 'Heart',
        patients: '250+',
        experience: '5 years',
        clinicAddr: 'Piplod,Surat.'),
    Doctor(
        name: 'cde',
        type: 'Eye',
        patients: '250+',
        experience: '5 years',
        clinicAddr: 'Piplod,Surat.'),
  ];

  List<Doctor> get docs {
    return [..._docs];
  }

  List<Doctor> findByType(String type) {
    return docs.where((element) => element.type == type).toList();
  }
}
