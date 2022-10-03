import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List selectedslot = [];
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay == focusedDay
                          ? selectedslot
                          : selectedslot.clear();
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 5 / 3,
              children: [
                for (int i = 0; i < 10; i++)
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedslot.contains(i)
                            ? selectedslot.remove(i)
                            : selectedslot.add(i);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 16,
                      width: 16,
                      color:
                          selectedslot.contains(i) ? Colors.amber : Colors.grey,
                      child: Center(
                        child: Text('${i}AM - ${i + 1}AM'),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      )),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Text('book')),
    );
  }
}
