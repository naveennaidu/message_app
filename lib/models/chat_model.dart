class ChatModel {
  final String name;
  final String datetime;
  final String message;
  final int endpoint;

  ChatModel({this.endpoint, this.name, this.datetime, this.message});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        name: json['username'],
        datetime: json['lastmessage']["created_at"],
        message: json['lastmessage']["body"],
        endpoint: json['chatroom_id']
    );
  }
}
