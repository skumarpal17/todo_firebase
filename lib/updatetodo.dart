import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UpdateTodo extends StatefulWidget {
  final String todo;
  final String uid;
  final String docId;
  const UpdateTodo({Key? key, required this.todo, required this.uid, required this.docId}) : super(key: key);

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  TextEditingController textcontrooler = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textcontrooler = widget.todo == null ? TextEditingController() : TextEditingController(text: widget.todo);
  }
  CollectionReference firebase = FirebaseFirestore.instance.collection('mycrud');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller:textcontrooler,
                maxLength: 100,
                minLines: 1,
              ),
              ElevatedButton(onPressed: (){
                firebase.doc(widget.uid).collection("task2").doc(widget.docId).update({
                  "input": textcontrooler.text,
                  "time": DateTime.now()
                });
                Navigator.of(context).pop();

              }, child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
