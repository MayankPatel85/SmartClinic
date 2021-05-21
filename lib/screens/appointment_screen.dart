import 'package:flutter/material.dart';
import 'package:smartclinic/providers/doctor.dart';
import 'package:table_calendar/table_calendar.dart';

//import '../providers/appointments.dart';
import '../widgets/apt_timings.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment-screen';

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
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

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2020),
  //       lastDate: DateTime(2022, selectedDate.month, selectedDate.day));
  //   if (picked != null) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final docDetail = ModalRoute.of(context).settings.arguments as Doctor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        //backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Select date:',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TableCalendar(
                calendarController: _calendarController,
                onDaySelected: (day, events, holidays) {
                  setState(() {
                    _selectedDate = day;
                  });
                },
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                'Select Time:',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Expanded(child: AptTiming(docDetail, _selectedDate)),
          ],
        ),
      ),
    );
  }
}
