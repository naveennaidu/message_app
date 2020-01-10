class ChatRoom {
  final String partnerName;
  final DateTime lastTime;
  final String lastMessage;
  final int endpoint;

  ChatRoom({this.partnerName, this.lastTime, this.lastMessage, this.endpoint});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    if (json['lastmessage'] != null) {
      return ChatRoom(
          partnerName: json['username'],
          lastTime: DateTime.parse(json['last_message']["created_at"]),
          lastMessage: json['last_message']["body"],
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
