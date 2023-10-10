class Message {
  final String id;
  final String messageText;

  Message({
    required this.messageText,
    required this.id,
  });

  factory Message.fromJson(map) {
    return Message(
      messageText: map['message'],
      id: map['id'],
    );
  }
}
