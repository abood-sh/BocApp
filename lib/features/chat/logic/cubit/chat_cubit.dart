// chat_cubit.dart
import 'package:doc_app/features/chat/data/model/message_model.dart';
import 'package:doc_app/features/chat/data/repos/message_repo.dart';
import 'package:doc_app/features/chat/logic/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final MessageRepository _messageRepository;
  final String _currentUserId; // From your auth system
  final String _receiverId;
  String get currentUserId => _currentUserId;

  ChatCubit({
    required MessageRepository messageRepository,
    required String currentUserId,
    required String receiverId,
  }) : _messageRepository = messageRepository,
       _currentUserId = currentUserId,
       _receiverId = receiverId,
       super(ChatInitial());

  Stream<List<MessageModel>> get messagesStream {
    final chatId = MessageModel.generateChatId(_currentUserId, _receiverId);
    return _messageRepository.getMessagesStream(chatId);
  }

  void sendTextMessage(String text) {
    _messageRepository.sendTextMessage(
      senderId: _currentUserId,
      receiverId: _receiverId,
      content: text,
    );
  }

  void sendImageMessage(String imageUrl) {
    _messageRepository.sendImageMessage(
      senderId: _currentUserId,
      receiverId: _receiverId,
      imageUrl: imageUrl,
    );
  }
}
