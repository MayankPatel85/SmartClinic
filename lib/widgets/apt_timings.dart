import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smartclinic/providers/doctor.dart';
import 'package:smartclinic/screens/launch_screen.dart';

import '../providers/appointments.dart';

class AptTiming extends StatelessWidget {
  final Doctor docDetail;
  final DateTime date;
  //final String time;

  AptTiming(this.docDetail, this.date);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    void showConfirmDialouge(String text) async {
      Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (ctx) => CupertinoAlertDialog(
                    title: Text(text),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx)
                              .popAndPushNamed(LaunchScreen.routeName);
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  ))
          : showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(text),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popAndPushNamed(LaunchScreen.routeName);
                    },
                    child: Text('Ok'),
                  ),
                ],
              ),
            );
    }

    Future<void> modeDialouge() async {
      Platform.isIOS
          ? await showCupertinoDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                        title: Text('Select mode'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('Online'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('Offline'),
                          ),
                        ],
                      ))
              .then((value) => showConfirmDialouge('Appointment confirmed.'))
          : showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Select mode'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popAndPushNamed(LaunchScreen.routeName);
                    },
                    child: Text('Ok'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).popAndPushNamed(LaunchScreen.routeName);
                    },
                    child: Text('Offline'),
                  ),
                ],
              ),
            ).then((value) => showConfirmDialouge('Appointment confirmed.'));
    }

    Future<void> _submitAppointment(String time) async {
      // Provider.of<Appointments>(context, listen: false)
      //     .addAppointment(docDetail.type, date, time);
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(user.uid)
          .collection('userAppointments')
          .add({
        'docType': docDetail.type,
        'date': date.toIso8601String(),
        'time': time,
        'createdAt': Timestamp.now(),
      });
      modeDialouge();
    }

    final availableTime = Provider.of<Appointments>(context).availableTime;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 70, childAspectRatio: 0.75),
        itemCount: availableTime.length,
        itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(10),
            child: TimingContainer(
              time: availableTime[index],
              taped: () {
                _submitAppointment(availableTime[index]);
              },
            )));
    // return Wrap(
    //   runSpacing: 20,
    //   spacing: 20,
    //   children: [
    //     TimeContainer(time: availableTime[0]),
    //     TimeContainer(time: availableTime[1]),
    //     TimeContainer(time: availableTime[2]),
    //     TimeContainer(time: availableTime[3]),
    //     TimeContainer(time: availableTime[4]),
    //   ],
    // );
    // return GridView.count(
    //   shrinkWrap: true,
    //   crossAxisSpacing: 3,
    //   mainAxisSpacing: 3,
    //   crossAxisCount: 2,
    //   children: [
    //     Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: TextButton(
    //           onPressed: () {
    //             Provider.of<Appointments>(context, listen: false)
    //                 .addAppointment(docDetail.type, date, availableTime[0]);
    //             Navigator.of(context).pop();
    //             showConfirmDialouge();
    //           },
    //           child: Text(
    //             availableTime[0],
    //             style: TextStyle(
    //               fontSize: 20,
    //             ),
    //           )),
    //     ),
    //     Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: TextButton(
    //           onPressed: () {
    //             Provider.of<Appointments>(context)
    //                 .addAppointment(docDetail.type, date, availableTime[1]);
    //             Navigator.of(context).pushReplacementNamed('/');
    //             showConfirmDialouge();
    //           },
    //           child: Text(
    //             availableTime[1],
    //             style: TextStyle(
    //               fontSize: 20,
    //             ),
    //           )),
    //     ),
    //     Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: TextButton(
    //           onPressed: () {
    //             Provider.of<Appointments>(context)
    //                 .addAppointment(docDetail.type, date, availableTime[2]);
    //           },
    //           child: Text(
    //             availableTime[2],
    //             style: TextStyle(
    //               fontSize: 20,
    //             ),
    //           )),
    //     ),
    //     Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: TextButton(
    //           onPressed: () {
    //             Provider.of<Appointments>(context)
    //                 .addAppointment(docDetail.type, date, availableTime[3]);
    //           },
    //           child: Text(
    //             availableTime[3],
    //             style: TextStyle(
    //               fontSize: 20,
    //             ),
    //           )),
    //     ),
    //     Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: TextButton(
    //           onPressed: () {
    //             Provider.of<Appointments>(context)
    //                 .addAppointment(docDetail.type, date, availableTime[04]);
    //           },
    //           child: Text(
    //             availableTime[4],
    //             style: TextStyle(
    //               fontSize: 20,
    //             ),
    //           )),
    //     ),
    //   ],
    // );
  }
}

class TimingContainer extends StatelessWidget {
  final String time;
  final Function taped;
  const TimingContainer({
    Key key,
    this.time,
    this.taped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: taped,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFF3490de),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  final String time;
  const TimeContainer({
    Key key,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        // height: 15,
        width: constraint.maxWidth / 2 - 40,
        decoration: BoxDecoration(
          color: Color(0xFFa8d8ea),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          time,
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
