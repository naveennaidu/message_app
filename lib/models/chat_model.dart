class ChatModel {
  final String name;
  final String datetime;
  final String message;

  ChatModel({this.name, this.datetime, this.message});

  static final List<ChatModel> dummyData = [
    ChatModel(
      name: "Laurent",
      datetime: "20:18",
      message: "How about meeting tomorrow?",
    ),
    ChatModel(
      name: "Tracy",
      datetime: "19:22",
      message: "I love that idea, it's great!",
    ),
    ChatModel(
      name: "Claire",
      datetime: "14:34",
      message: "I wasn't aware of that. Let me check",
    ),
  ];
}
