import 'package:flutter/material.dart';

import 'dialog_flow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Chatbot",
      debugShowCheckedModeBanner: false,
      home: FlutterFactsChatBots(),
    );
  }
}
