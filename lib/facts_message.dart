import 'dart:io';

import 'package:flutter/material.dart';

class Facts extends StatelessWidget {
  Facts({this.text, this.name, this.type, this.dataFile, this.file});

  final dynamic text;
  final String name;
  final bool type;
  final bool dataFile;
  final File file;

  List<Widget> botMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              "assets/images/robot.png",
              width: 35,
            )),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(text),
              ),
            )
          ],
        ),
      )
    ];
  }

  List<Widget> fileMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 100,
              child: Card(
                elevation: 5,
                color: Color(0xffff7f50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.picture_as_pdf,
                        size: 35,
                      ),
                      Container(
                        width: 100,
                        height: 2,
                        color: Colors.black,
                        margin: EdgeInsets.symmetric(vertical: 5),
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          child: new Text(
            "You",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          backgroundColor: Colors.grey[200],
          radius: 20,
        ),
      )
    ];
  }

  List<Widget> userMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Card(
              color: Color(0xffff7f50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    text,
                  )),
            )
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          child: new Text(
            "You",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          backgroundColor: Colors.grey[200],
          radius: 20,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dataUser(BuildContext context) {
      return this.dataFile ? fileMessage(context) : userMessage(context);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? dataUser(context) : botMessage(context),
      ),
    );
  }
}
