// lib/features/chat/logic/cubit/chat_cubit.dart
import 'dart:async';
import 'package:doc_app/features/chat/data/repos/message_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _messagesSubscription;

  ChatCubit(this._chatRepository) : super(ChatInitial());

  void startChat(String receiverId) {
    emit(ChatLoading());

    _messagesSubscription?.cancel();
    _messagesSubscription = _chatRepository
        .getMessages(receiverId)
        .listen(
          (messages) => emit(ChatLoaded(messages: messages)),
          onError: (error) => emit(ChatError(error.toString())),
        );
  }

  Future<void> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    try {
      if (state is ChatLoaded) {
        emit(
          ChatLoaded(messages: (state as ChatLoaded).messages, isSending: true),
        );
      }

      await _chatRepository.sendMessage(
        receiverId: receiverId,
        content: content,
      );

      if (state is ChatLoaded) {
        emit(
          ChatLoaded(
            messages: (state as ChatLoaded).messages,
            isSending: false,
          ),
        );
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
