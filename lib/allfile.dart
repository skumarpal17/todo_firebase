import 'package:flutter/material.dart';

import 'booking.dart';
import 'bookmark.dart';

class Allfile extends StatefulWidget {
  final List bookmarklit;
  const Allfile({Key? key, required this.bookmarklit}) : super(key: key);

  @override
  State<Allfile> createState() => _AllfileState();
}

class _AllfileState extends State<Allfile> {
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wd = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("All File"),
      ),
      body: ListView(
        children: [
          GestureDetector(
            child: Container(
              child: Center(child: Text("Bookmark")),
              color: Colors.amber,
              width: wd,
              height: ht * 0.1,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Bookmark(
                        bookmarklist: widget.bookmarklit,
                      )));
            },
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: Container(
              child: Center(child: Text("Booking")),
              color: Colors.amber,
              width: wd,
              height: ht * 0.1,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Booking()));
            },
          )
        ],
      ),
    );
  }
}
