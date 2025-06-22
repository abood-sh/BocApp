// message_repo.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/features/chat/data/model/message_model.dart';

class MessageRepository {
  final CollectionReference<MessageModel> _messagesCollection;

  MessageRepository()
    : _messagesCollection = FirebaseFirestore.instance
          .collection('messages')
          .withConverter<MessageModel>(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromFirestore(snapshot, null),
            toFirestore: (message, _) => message.toFirestore(),
          );

  // Send text message
  Future<void> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    final chatId = MessageModel.generateChatId(senderId, receiverId);
    final message = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      chatId: chatId,
      content: content,
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    );

    await _messagesCollection.add(message);
  }

  // Send image message
  Future<void> sendImageMessage({
    required String senderId,
    required String receiverId,
    required String imageUrl,
  }) async {
    final chatId = MessageModel.generateChatId(senderId, receiverId);
    final message = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      chatId: chatId,
      content: imageUrl,
      sentTime: DateTime.now(),
      messageType: MessageType.image,
    );

    await _messagesCollection.add(message);
  }

  // Get messages stream
  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    return _messagesCollection
        .where('chatId', isEqualTo: chatId)
        .orderBy('sentTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
