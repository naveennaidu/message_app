class Message {
  final String text;
  final String createdAt;
  final bool belongsToCurrentUser;

  Message({this.text, this.createdAt, this.belongsToCurrentUser});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        text: json['body'],
        createdAt: json['created_at'],
        belongsToCurrentUser: json["sender"] == "self"
    );
  }
}
