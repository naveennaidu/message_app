class Message {
  final String text;
  final String createdAt;
  final int belongsToCurrentUser;

  Message({this.text, this.createdAt, this.belongsToCurrentUser});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        text: json['message'],
        createdAt: json['created_at'],
        belongsToCurrentUser: json["sender"]
    );
  }
}
