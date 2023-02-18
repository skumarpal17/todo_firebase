import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bookmark extends StatefulWidget {
  final List bookmarklist;
  const Bookmark({Key? key, required this.bookmarklist}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  // List favouritelist = [];
  var firestore = FirebaseFirestore.instance.collection("bookmark");
  // // firestore.map((docs){})
  // // var val = firestore.docs map((doc) => favouritelist.add(doc)).toList();
  // List allData = [];
  // Future<void> getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await firestore.get();
  //
  //   // Get data from docs and convert map to List
  //   allData = querySnapshot.docs.map((doc) => doc.id).toList();
  //   print("initstate $allData");
  //   print("initstate ${allData.length}");
  // }

  List finallist = [];

  onclick(int index) async {
    if (finallist.contains(index.toString())) {
      var id1 = firestore.doc(index.toString()).id;
      await widget.bookmarklist.remove(index.toString());
      FirebaseFirestore.instance.collection("bookmark").doc(id1).delete();
      // favouritelist.remove(index);
    } else {
      widget.bookmarklist.add(index.toString());
      await firestore.doc(index.toString()).set({"index": index.toString()});
      // favouritelist.add(index);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finallist = widget.bookmarklist;
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bokmark"),
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(index.toString()),
                trailing: IconButton(
                  onPressed: () {
                    // getData();
                    setState(() {
                      onclick(index);
                    });
                    // print("onClick $allData");
                    // print("onClick ${allData.length}");
                  },
                  icon: finallist.contains(index.toString())
                      ? Icon(Icons.bookmark)
                      : Icon(Icons.bookmark_border),
                ),
              );
            }));
  }
}
