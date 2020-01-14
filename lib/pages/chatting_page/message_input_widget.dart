import 'package:flutter/material.dart';

class MessageInputWidget extends StatefulWidget {
  final TextEditingController textController;
  bool isComposing;

  MessageInputWidget(
      {Key key, @required this.textController, @required this.isComposing})
      : super(key: key);
  @override
  _MessageInputWidgetState createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Flexible(
            child: new TextField(
              controller: widget.textController,
              onChanged: (String text) {
                setState(() {
                  widget.isComposing = !_isBlank(text);
                });
              },
//              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
                    color: widget.isComposing ? Colors.blue : Colors.grey),
//                    onPressed: widget.isComposing ? () => handleSubmitted(widget.textController.text) : null,
              )),
        ],
      ),
    );
  }

  bool _isBlank(String text) => text == null || text.trim().isEmpty;
}
