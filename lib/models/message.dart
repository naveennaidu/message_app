class Message {
  final int id;
  final String text;
  final int user_id;
  final String created_at;

  Message({this.id, this.text, this.user_id, this.created_at});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        text: json['body'],
        user_id: json['user_id'],
        created_at: json['created_at']
    );
  }
}
