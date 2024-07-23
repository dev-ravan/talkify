import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:talkify/features/home/data/model/message_mod.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/presentation/bloc/home_bloc.dart';
import 'package:talkify/features/home/presentation/components/chat_room_header.dart';
import 'package:talkify/init_dependencies.dart';
import 'package:talkify/utils/exports.dart';

class ChatRoom extends StatefulWidget {
  final UserModel currentUser;
  final UserModel otherUser;
  const ChatRoom({
    super.key,
    required this.currentUser,
    required this.otherUser,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  ChatUser? currentUser, receiveUser;
  @override
  void initState() {
    super.initState();
    receiveUser = ChatUser(
        id: widget.otherUser.uid,
        firstName: widget.otherUser.name,
        profileImage: widget.otherUser.photo);
    currentUser = ChatUser(
        id: widget.currentUser.uid,
        firstName: widget.currentUser.name,
        profileImage: widget.currentUser.photo);
    serviceLocator.get<HomeBloc>().add(GetChatMessagesEvent(
        currentUser: currentUser!, otherUser: receiveUser!));
  }

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
          if (state is ChatMessagesListSuccessState) {
            return Padding(
              padding: p16,
              child: Column(
                children: [
                  ChatRoomHeader(user: widget.otherUser),
                  Expanded(
                    child: DashChat(
                        inputOptions: chatFieldStyle(colorTheme),
                        currentUser: currentUser!,
                        onSend: (msg) {
                          final Message message = Message(
                              senderID: currentUser!.id,
                              content: msg.text,
                              messageType: MessageType.Text,
                              sentAt: Timestamp.fromDate(msg.createdAt));
                          context.read<HomeBloc>().add(SendMessageEvent(
                              receiveUser!.id,
                              message: message));
                          context.read<HomeBloc>().add(GetChatMessagesEvent(
                              currentUser: currentUser!,
                              otherUser: receiveUser!));
                        },
                        messages: state.messages),
                  )
                ],
              ),
            );
          }
          // Error
          else if (state is ChatMessagesListFailureState) {
            return Center(
              child: Text(
                state.error,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          } else if (state is ChatMessagesListLoadingState) {
            // Loading
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return Container();
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
