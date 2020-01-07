class Message {
  final String text;
  final String created_at;
  final int betongs_to_current_user;

  Message({this.text, this.created_at, this.betongs_to_current_user});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        text: json['message'],
        created_at: json['created_at'],
        betongs_to_current_user: json["sender"]
    );
  }
}
