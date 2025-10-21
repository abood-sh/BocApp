import 'package:doc_app/core/di/dependency_injection.dart';
import 'package:doc_app/features/chat/data/model/user_model.dart';
import 'package:doc_app/features/chat/logic/cubit/chat_cubit.dart';
import 'package:doc_app/features/chat/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListViewItem extends StatelessWidget {
  final UserModel user;

  const UserListViewItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<ChatCubit>(),
              child: ChatScreen(receiverId: user.uid, receiverName: user.name),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: user.profileImageUrl.isNotEmpty
                  ? NetworkImage(user.profileImageUrl)
                  : const AssetImage('assets/images/avatar.png')
                        as ImageProvider,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 14,
                      color: user.isOnline ? Colors.green : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
