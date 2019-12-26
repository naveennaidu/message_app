import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
  await http.get('https://stormy-savannah-90253.herokuapp.com/api/users');

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  final String user;

  Post({this.user});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      user: json['user'],
    );
  }
}

class ChattingPage extends StatelessWidget {
  static const String routeName = 'chatting';

  @override
  Widget build(BuildContext context) {
    final title = 'Chatting';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return Text(snapshot.data.user);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        )
      ),
    );
  }
}