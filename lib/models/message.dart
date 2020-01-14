class Message {
  final String text;
  final DateTime createdAt;
  final bool belongsToCurrentUser;

  Message({this.text, this.createdAt, this.belongsToCurrentUser});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        text: json['body'],
        createdAt: DateTime.parse(json['created_at']).toLocal(),
        belongsToCurrentUser: json['sent_by']['user'] == "self"
    );
  }
}
