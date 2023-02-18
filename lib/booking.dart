import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List selectedslot = [];
  List allData = [];
  List slotList1 = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
    getList();
  }

  List l1 = [];

  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();

  List slotlist = [
    {"slot": "1AM-2AM", "booked": false},
    {"slot": "2AM-3AM", "booked": false},
    {"slot": "3AM-4AM", "booked": false},
    {"slot": "4AM-5AM", "booked": false},
    {"slot": "5AM-6AM", "booked": false},
    {"slot": "6AM-7AM", "booked": false},
    {"slot": "7AM-8AM", "booked": false},
    {"slot": "8AM-9AM", "booked": false},
    {"slot": "9AM-10AM", "booked": false},
  ];
  var collection = FirebaseFirestore.instance.collection('booking');
  var data;
  var querySnapshot;
  List idList = [];

  getList() async {
    idList = [];
    allData = [];
    querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      var id = queryDocumentSnapshot.id; // to get doc id
      idList.add(id);
      data = queryDocumentSnapshot.data();
      allData.add(data);
    }
    print("idList $idList");
    print("idList ${idList.length}");

    // print("length ${allData.length}");
    // print("all data1 ${allData}");
  }

  @override
  Widget build(BuildContext context) {
    double wd = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TableCalendar(
                  firstDay: DateTime.now(),
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
            idList.contains(
                    DateFormat("yMMMMd").format(_selectedDay).toString())
                ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: collection
                        .doc(DateFormat("yMMMMd")
                            .format(_selectedDay)
                            .toString())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }
                      l1 = snapshot.data!["slot"];
                      return GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 5 / 3,
                        children: [
                          for (int i = 0;
                              i < snapshot.data!["slot"].length;
                              i++)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedslot.contains(i)
                                      ? selectedslot.remove(i)
                                      : selectedslot.add(i);

                                  ///*******************************************
                                  if (snapshot.data!["slot"][i]["booked"]) {
                                    var snackBar = SnackBar(
                                        content: Text(
                                            'This slot is already booked'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    print("slot is booked");
                                  } else {
                                    if (selectedslot.contains(i)) {
                                      print(i);
                                      print("$selectedslot");
                                      l1[i]["booked"] = true;
                                      print("slot is not booked yet ${l1}");
                                    } else {
                                      l1[i]["booked"] = false;
                                      print("l1[i][booked] ${l1[i]["booked"]}");
                                    }
                                    // l1[i] =

                                  }

                                  ///*******************************************
                                });
                              },
                              child: snapshot.data!["slot"][i]["booked"]
                                  ? Container(
                                      margin: EdgeInsets.all(8),
                                      height: 16,
                                      width: 16,
                                      color: Colors.red,
                                      child: Center(
                                        child: Text('${i}AM - ${i + 1}AM'),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.all(8),
                                      height: 16,
                                      width: 16,
                                      color: selectedslot.contains(i)
                                          ? Colors.amber
                                          : Colors.grey,
                                      child: Center(
                                        child: Text('${i}AM - ${i + 1}AM'),
                                      ),
                                    ),
                            )
                        ],
                      );
                    })
                : GridView.count(
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
                            color: selectedslot.contains(i)
                                ? Colors.amber
                                : Colors.grey,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
          onTap: () {
            // var datetime = DateFormat("yMMMMd").format(_selectedDay).toString();
            // print("datetime $datetime");
            // FirebaseFirestore.instance
            //     .collection("booking")
            //     .doc('$datetime')
            //     .set({
            //   "slot": slotlist,
            // });
            // print("_selectedDay $_selectedDay");
            FirebaseFirestore.instance
                .collection("booking")
                .doc("${DateFormat("yMMMMd").format(_selectedDay)}")
                .update({
              "slot": l1,
            });
            print("tis iss doc ${DateFormat("yMMMMd").format(_selectedDay)}");
            print(l1);
            getList();
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(8)),
              height: 50,
              width: wd * 0.75,
              child: Center(child: Text('book')))),
    );
  }
}
