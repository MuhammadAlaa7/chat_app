class Message {
  final String messageText;

  Message({
    required this.messageText,
  });

  factory Message.fromJson(map) {
    return Message(messageText: map['message']);
  }
}
