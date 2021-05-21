import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:smartclinic/widgets/show_progress_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class UpcoimngAppointmentsScreen extends StatefulWidget {
  static const routeName = 'upcoming-appointments';

  @override
  _UpcoimngAppointmentsScreenState createState() =>
      _UpcoimngAppointmentsScreenState();
}

class _UpcoimngAppointmentsScreenState
    extends State<UpcoimngAppointmentsScreen> {
  //DateTime _focusedDate = DateTime.now();
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    //final appointData = Provider.of<Appointments>(context).resAppot;
    //final appointDates = Provider.of<Appointments>(context).apptDates;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Appointments',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: TableCalendar(
              calendarController: _calendarController,
              headerStyle: HeaderStyle(formatButtonVisible: false),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.grey),
              ),
              calendarStyle: CalendarStyle(
                weekendStyle: TextStyle(color: Colors.black),
                outsideWeekendStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(user.uid)
                    .collection('userAppointments')
                    .orderBy('createdAt', descending: false)
                    .snapshots(),
                builder: (ctx, aptSnapshot) {
                  if (aptSnapshot.connectionState == ConnectionState.waiting) {
                    return ShowProgressIndicator();
                  }
                  final aptDocs = aptSnapshot.data.docs;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ListView.builder(
                      itemCount: aptDocs.length,
                      itemBuilder: (context, i) {
                        final item = aptDocs[i].id;
                        return Dismissible(
                          key: Key(item),
                          background: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            FirebaseFirestore.instance
                                .collection('appointments')
                                .doc(user.uid)
                                .collection('userAppointments')
                                .doc(item.toString())
                                .delete();
                          },
                          child: AppointmentContainer(
                            date: DateTime.parse(aptDocs[i].data()['date']),
                            time: aptDocs[i].data()['time'],
                            type: aptDocs[i].data()['docType'],
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class AppointmentContainer extends StatelessWidget {
  final String time;
  final DateTime date;
  final String type;
  const AppointmentContainer({
    Key key,
    this.time,
    this.date,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFa8d8ea),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            DateFormat.MMMMd().format(date),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Column(
            children: [
              Text(type),
              Text(time),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.call,
                color: Colors.white,
              ),
              onPressed: null),
        ],
      ),
    );
  }
}
