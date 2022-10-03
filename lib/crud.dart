import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudopertion/updatetodo.dart';
import 'package:flutter/material.dart';

import 'booking.dart';
import 'bookmark.dart';
import 'database/database.dart';

class Crud extends StatefulWidget {
  final String uid;
  const Crud({Key? key, required this.uid}) : super(key: key);

  @override
  State<Crud> createState() => _CrudState(uid);
}

class _CrudState extends State<Crud> {
  final String uid;
  _CrudState(this.uid);
  CollectionReference firebase =
      FirebaseFirestore.instance.collection('mycrud');

  TextEditingController mytext = TextEditingController();
  String text2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Bookmark(),
                ));
              },
              icon: Icon(Icons.flutter_dash_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                controller: mytext,
                onChanged: (value) {
                  text2 = value;
                },
                decoration: InputDecoration(
                    hintText: 'Write your data', border: OutlineInputBorder()),
              ),
            ),
            ////////////////////////////////////////////////////////////////////// sending data into firebase
            ElevatedButton(
                onPressed: () async {
                  if (mytext.text != "" && mytext.text != " ") {
                    setState(() {
                      mytext.text = "";
                    });
                    await firebase
                        .doc(uid)
                        .collection("task2")
                        .add({'input': text2, "time": DateTime.now()});
                  }
                },
                child: Text("Submit")),
            //////////////////////////////////////////////////////////////////////
            StreamBuilder(
                stream: firebase
                    .doc(uid)
                    .collection("task2")
                    .orderBy("time")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No data"),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            var a = snapshot.data!.docs[index].id;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateTodo(
                                      todo: snapshot.data!.docs[index]['input'],
                                      uid: widget.uid,
                                      docId: a.toString(),
                                    )));
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(snapshot.data!.docs[index]['input']),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                highlightColor: Colors.red,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Are you want to delete'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  var a = snapshot
                                                      .data!.docs[index].id;
                                                  FirebaseFirestore.instance
                                                      .collection('mycrud')
                                                      .doc(uid)
                                                      .collection("task2")
                                                      .doc(a)
                                                      .delete();
                                                  print(a);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Yes')),
                                            SizedBox(
                                              width: 17,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('No')),
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
