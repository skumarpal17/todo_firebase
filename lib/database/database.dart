import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Realdata extends StatefulWidget {
  const Realdata({Key? key}) : super(key: key);

  @override
  State<Realdata> createState() => _RealdataState();
}

class _RealdataState extends State<Realdata> {
  var database = FirebaseDatabase.instance.ref("rootNode");
  var textfield = TextEditingController();
  List messages =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("database $database");
    printt();
  }

  printt() async{
    List list = [];
    database.onValue.listen((event) {
      final snapshot = event.snapshot.value;
      print("snapshot $snapshot");
      if(snapshot != null){
        Map map2 = snapshot as Map;
        print("map2 ${map2}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RealTime Database"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView( 
            child: Column(
              children: [
                TextField(
                  controller: textfield,
                  decoration: const InputDecoration(
                    border:  OutlineInputBorder()
                  ),
                ),
                ElevatedButton(onPressed: ()  {
                  database.push().set({
                    "entery":textfield.text,
                  });
                }, child: Text("Submit")),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
