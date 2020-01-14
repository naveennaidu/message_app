class ChatRoom {
  final String partnerName;
  final DateTime lastTime;
  final String lastMessage;
  final int endpoint;

  ChatRoom({this.partnerName, this.lastTime, this.lastMessage, this.endpoint});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    if (json['last_message'] != null) {
      return ChatRoom(
          partnerName: json['other_user']['name'],
          lastTime: DateTime.parse(json['last_message']['created_at']).toLocal(),
          lastMessage: json['last_message']['body'],
          endpoint: json['id']
      );
    } else {
      return ChatRoom(
          partnerName: json['other_user']['name'],
          lastTime: null,
          lastMessage: '',
          endpoint: json['id']
      );
    }

  }
}
