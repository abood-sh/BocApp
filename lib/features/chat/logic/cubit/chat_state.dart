// lib/features/chat/logic/cubit/chat_state.dart

import 'package:doc_app/features/chat/data/model/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageModel> messages;
  final bool isSending;

  ChatLoaded({required this.messages, this.isSending = false});
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
