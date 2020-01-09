// I don't understand the usage of this model. Can you explain?
// To me, it seems to be the same as message. Why do you have both?
// You problem should change the name of this class
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
          lastTime: DateTime.parse(json['lastmessage']["created_at"]),
          lastMessage: json['lastmessage']["body"],
          endpoint: json['chatroom_id']
      );
    } else {
      return ChatRoom(
          partnerName: json['username'],
          lastTime: null,
          lastMessage: "",
          endpoint: json['chatroom_id']
      );
    }

  }
}
