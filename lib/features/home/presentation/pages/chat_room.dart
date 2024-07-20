import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/presentation/bloc/home_bloc.dart';
import 'package:talkify/features/home/presentation/components/chat_room_header.dart';
import 'package:talkify/utils/exports.dart';

class ChatRoom extends StatefulWidget {
  final UserModel chatUser;
  const ChatRoom({super.key, required this.chatUser});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is ChatRoomToHomeNavigateStete) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final user = widget.chatUser;
          final currentUser = ChatUser(
              id: user.uid, firstName: user.name, profileImage: user.photo);
          return Padding(
            padding: p16,
            child: Column(
              children: [
                ChatRoomHeader(user: widget.chatUser),
                Expanded(
                  child: DashChat(
                      currentUser: currentUser, onSend: (msg) {}, messages: []),
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
