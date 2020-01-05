import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:message_app/models/message.dart';
import 'package:message_app/utils/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChattingPage extends StatefulWidget {
  static const String routeName = 'chatting';
  final String endpoint;

  const ChattingPage({Key key, this.endpoint}) : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final TextEditingController _textController = new TextEditingController();
  HttpService _httpService = new HttpService();
  bool _isComposing = false;
  String token;

  List<Message> listmessage;

  BubbleStyle styleMe = BubbleStyle(
    nip: BubbleNip.rightTop,
    color: Color.fromARGB(255, 225, 255, 199),
    margin: BubbleEdges.only(top: 8.0, left: 50.0),
    alignment: Alignment.topRight,
  );

  BubbleStyle styleSomebody = BubbleStyle(
    nip: BubbleNip.leftTop,
    color: Colors.white,
    margin: BubbleEdges.only(top: 8.0, right: 50.0),
    alignment: Alignment.topLeft,
  );

  void _handleSubmitted(String text) {
    _httpService.post("https://stormy-savannah-90253.herokuapp.com/api/message?body=$text", token);
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Chatting';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
          color: Colors.yellow.withAlpha(64),
          child: Column(
            children: <Widget>[
              Flexible(
                child: FutureBuilder<List<Message>>(
                  future: makePostRequest(),
                  builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Bubble(
                              style: snapshot.data[index].user_id == 5 ? styleMe : styleSomebody,
                              child: Text("${snapshot.data[index].text}"),
                            );
                          },
                          itemCount: snapshot.data.length,
                        );
                    }

                  } ,
                ),
              ),
              Divider(height: 1.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: new TextField(
                        controller: _textController,
                        onChanged: (String text) {
                          setState(() {
                            _isComposing = text.length > 0;
                          });
                        },
                        onSubmitted: _handleSubmitted,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          filled: true,
                          fillColor: Colors.white10,
                          hintText: "send a message",
                        ),
                      ),
                    ),
                    Container(
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconButton(
                          icon: new Icon(Icons.send,
                              color: _isComposing ? Colors.blue : Colors.grey),
                          onPressed: _isComposing
                              ? () => _handleSubmitted(_textController.text)
                              : null,
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<List<Message>> makePostRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    List<Message> listmessage = await _httpService.fetchMessages("https://stormy-savannah-90253.herokuapp.com/api/chatroom/2", token);
    return listmessage;
  }
}
