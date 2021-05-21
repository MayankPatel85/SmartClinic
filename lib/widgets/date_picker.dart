import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime currentDate = DateTime.now();
  int dateIndex = 0;
  String day(int dayWeek) {
    switch (dayWeek) {
      case 1:
        return 'M';
        break;
      case 2:
        return 'T';
        break;
      case 3:
        return 'W';
        break;
      case 4:
        return 'T';
        break;
      case 5:
        return 'F';
        break;
      case 6:
        return 'S';
        break;
      case 7:
        return 'S';
        break;
      default:
        return 'M';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.MMMM().format(currentDate),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat.y().format(currentDate),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (ctx, index) {
                var date = currentDate.add(Duration(days: index));
                return GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        dateIndex = index;
                        //print(dateIndex);
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    width: 44,
                    decoration: BoxDecoration(
                      color: dateIndex == index
                          ? Color(0xFFa8d8ea)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day(date.weekday),
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                              color: dateIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
