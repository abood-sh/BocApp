import 'package:doc_app/core/theming/styles.dart';
import 'package:doc_app/features/chat/logic/cubit/user_cubit.dart';
import 'package:doc_app/features/chat/logic/cubit/user_state.dart';
import 'package:doc_app/features/chat/ui/widget/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUsersScreen extends StatefulWidget {
  const ChatUsersScreen({super.key});

  @override
  State<ChatUsersScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatUsersScreen> {
  @override
  void initState() {
    context.read<UserCubit>().getUsersStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat', style: TextStyles.font24BlackBold(context)),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UsersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (users) => UserListView(userModelData: users),
              error: (error) => Center(child: Text(error)),
            );
          },
        ),
      ),
    );
  }
}
