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
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is ChatRoomToHomeNavigateState) {
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
                      inputOptions: chatFieldStyle(colorTheme),
                      currentUser: currentUser,
                      onSend: (msg) {},
                      messages: []),
                )
              ],
            ),
          );
        },
      ),
    ));
  }

  InputOptions chatFieldStyle(ColorScheme colorTheme) {
    return InputOptions(
        alwaysShowSend: true,
        autocorrect: true,
        sendOnEnter: true,
        sendButtonBuilder: (send) => InkWell(
              onTap: send,
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorTheme.outline),
                    color: colorTheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.send,
                    size: 24,
                    color: colorTheme.primary,
                  )),
            ),
        inputDecoration: InputDecoration(
            hintText: "Message",
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: colorTheme.primaryContainer),
            isDense: true,
            contentPadding: const EdgeInsets.all(14),
            fillColor: colorTheme.secondary,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorTheme.primary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorTheme.outline)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorTheme.outline))));
  }
}
