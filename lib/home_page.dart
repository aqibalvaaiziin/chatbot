import 'package:chatbot/dialog_flow.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _animation = Tween(begin: 0.0, end: 35.0).animate(_controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          print("completed");
        } else if (state == AnimationStatus.dismissed) {
          print("dismissed");
        }
      })
      ..addListener(() {
        setState(() {});
        print("value:${_animation.value}");
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: InkWell(
            splashColor: Colors.deepOrange,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FlutterFactsChatBots()));
            },
            child: Icon(
              Icons.chat,
              color: Colors.orange,
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.orange[200],
                Colors.orange[400],
                Colors.orange[600],
                Colors.orange[800],
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          Positioned(
            top: 130,
            left: _animation.value,
            child: Text(
              "Hai",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 180,
            left: _animation.value,
            child: Text(
              "Aku PBot,",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 230,
            left: _animation.value,
            child: Container(
              width: 300,
              child: Text(
                "Aku akan membantumu melakukan convert data pdf ke video,untuk lengkapnya tanyalah padaku. ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
              top: 580,
              right: 35,
              left: _animation.value,
              child: Container(
                width: 300,
                height: 70,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.orange[900], blurRadius: 55)
                ]),
              )),
          Positioned(
            top: 450,
            right: 35,
            left: _animation.value,
            child: Container(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/robo.png",
                      width: 200,
                      height: 200,
                    ),
                    Image.asset(
                      "assets/images/pdf.png",
                      width: 122,
                      height: 122,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
