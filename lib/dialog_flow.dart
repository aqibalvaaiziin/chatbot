import 'dart:io';

import 'package:flutter/material.dart';
import 'facts_message.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class FlutterFactsChatBots extends StatefulWidget {
  FlutterFactsChatBots({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterFactsChatBotsState createState() => _FlutterFactsChatBotsState();
}

class _FlutterFactsChatBotsState extends State<FlutterFactsChatBots> {
  final List<Facts> messageList = <Facts>[];
  final TextEditingController _textChat = new TextEditingController();
  File dataFile;
  String fileName = "";

  Widget _queryInputWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.88,
          height: MediaQuery.of(context).size.width * 0.18,
          child: Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField(
                cursorColor: Color(0xffff7f50),
                controller: _textChat,
                onSubmitted: _submitQuery,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Kirim Pesan......",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        return showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    Text("Pilih file yang ingin diupload ? "),
                                elevation: 2,
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () =>
                                          showFilePicker(FileType.custom),
                                      child: Text("Ambil File"))
                                ],
                              );
                            });
                      },
                      child: Icon(
                        Icons.cloud_upload,
                        color: Color(0xffff7f50),
                      ),
                    )),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
          decoration:
              BoxDecoration(color: Color(0xffff7f50), shape: BoxShape.circle),
          child: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => _submitQuery(_textChat.text)),
        ),
      ],
    );
  }

  void agentResponse(query) async {
    _textChat.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credential.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.indonesian);
    AIResponse response = await dialogflow.detectIntent(query);
    Facts message = Facts(
      text: response.getMessage().toString() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "Flutter",
      type: false,
      dataFile: false,
    );
    setState(() {
      messageList.insert(0, message);
    });
  }

  void _submitQuery(dynamic text) {
    _textChat.clear();
    Facts message = new Facts(
      text: fileName != "" ? fileName : text,
      name: "User",
      type: true,
      dataFile: fileName != "" ? true : false,
    );
    setState(() {
      messageList.insert(0, message);
      fileName = "";
    });
    agentResponse(text);
  }

  showFilePicker(FileType fileType) async {
    dataFile =
        await FilePicker.getFile(type: fileType, allowedExtensions: ['pdf']);
    fileName += path.basename(dataFile.path);
    _submitQuery(fileType.toString());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chat Bots PDF Converter",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xffff7f50),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/lala2.png"),
                fit: BoxFit.fitHeight)),
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                reverse: true,
                itemBuilder: (_, int index) => messageList[index],
                itemCount: messageList.length,
              ),
            ),
            _queryInputWidget(context)
          ],
        ),
      ),
    );
  }
}
