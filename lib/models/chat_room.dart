class ChatRoom {
  final String partnerName;
  final DateTime lastTime;
  final String lastMessage;
  final int endpoint;

  ChatRoom({this.partnerName, this.lastTime, this.lastMessage, this.endpoint});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    if (json['last_message'] != null) {
      return ChatRoom(
          partnerName: json['username'],
          lastTime: DateTime.parse(json['last_message'][0]["created_at"]),
          lastMessage: json['last_message'][0]["body"],
          endpoint: json['id']
      );
    } else {
      return ChatRoom(
          partnerName: json['username'],
          lastTime: null,
          lastMessage: "",
          endpoint: json['id']
      );
    }

  }
}
