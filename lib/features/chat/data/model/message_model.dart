import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  text,
  image;

  String toFirestore() => name;
}

class MessageModel {
  final String senderId;
  final String receiverId;
    final String chatId; // Add this

  final String content;
  final DateTime sentTime;
  final MessageType messageType;
    final bool isSeen; // Add this


  MessageModel(
      {required this.senderId,
      required this.receiverId,
          required this.chatId, // Add this

      required this.content,
      required this.sentTime,
      required this.messageType,
          this.isSeen = false, // Add this
});

  factory MessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return MessageModel(
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      chatId: data['chatId'], // Extract chatId
      content: data['content'],
      sentTime: (data['sentTime'] as Timestamp).toDate(),
      messageType: data['messageType'],
      isSeen: data['isSeen'] ?? false, // Extract isSeen with default value
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'sentTime': Timestamp.fromDate(sentTime),
      'messageType': messageType,
    };
  }

  static String generateChatId(String user1, String user2) {
    final ids = [user1, user2]..sort();
    return '${ids[0]}_${ids[1]}';
  }
}
