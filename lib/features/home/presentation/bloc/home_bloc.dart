import 'dart:async';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:talkify/features/authentication/domain/usecase/user_logout.dart';
import 'package:talkify/features/home/data/model/message_mod.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/domain/usecase/create_chat_room.dart';
import 'package:talkify/features/home/domain/usecase/get_chat_messages.dart';
import 'package:talkify/features/home/domain/usecase/get_current_user.dart';
import 'package:talkify/features/home/domain/usecase/get_user_list.dart';
import 'package:talkify/features/home/domain/usecase/send_message.dart';
import 'package:talkify/utils/exports.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserLogout _userLogout;
  final GetUserList _getUserList;
  final GetCurrentUser _getCurrentUser;
  final CreateChatRoom _createChatRoom;
  final SendMessage _sendMessage;
  final GetChatMessages _getChatMessages;
  HomeBloc(
      {required GetUserList getUserList,
      required GetCurrentUser getCurrentUser,
      required UserLogout userLogout,
      required CreateChatRoom createChatRoom,
      required SendMessage sendMessage,
      required GetChatMessages getChatMessages})
      : _getUserList = getUserList,
        _getCurrentUser = getCurrentUser,
        _userLogout = userLogout,
        _createChatRoom = createChatRoom,
        _sendMessage = sendMessage,
        _getChatMessages = getChatMessages,
        super(HomeInitial()) {
    on<HomeInitialEvent>(_homeInitialEvent);
    on<HomeLogoutClickEvent>(_homeLogoutClickEvent);
    on<HomeChatUserClickEvent>(_homeChatUserClickEvent);
    on<ChatBackClickEvent>(_chatBackClickEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    on<GetChatMessagesEvent>(_getChatMessagesEvent);
  }

  FutureOr<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingStete());
    try {
      final userList = await _getUserList.getUserList();
      final user = await _getCurrentUser.getCurrentUser();
      user.fold(
        (l) => emit(HomeFailureStete(l.msg)),
        (user) {
          return userList.fold(
            (l) => emit(HomeSuccessState(const [], user)),
            (userList) => emit(HomeSuccessState(userList, user)),
          );
        },
      );
    } catch (e) {
      emit(HomeFailureStete(e.toString()));
    }
  }

  FutureOr<void> _homeLogoutClickEvent(
      HomeLogoutClickEvent event, Emitter<HomeState> emit) async {
    emit(LogoutLoadingStete());
    try {
      final result = await _userLogout.logout();
      result.fold(
        (l) => emit(LogoutFailureStete(l.msg)),
        (r) => emit(LogoutSuccessState(r)),
      );
    } catch (e) {
      emit(LogoutFailureStete(e.toString()));
    }
  }

  FutureOr<void> _homeChatUserClickEvent(
      HomeChatUserClickEvent event, Emitter<HomeState> emit) async {
    try {
      final res =
          await _createChatRoom.call(ChatRoomParams(event.otherUser.uid));
      res.fold(
        (l) => emit(ChatRoomNavigateFailureState(l.msg)),
        (r) => emit(
            ChatRoomNavigateSuccessState(event.currentUser, event.otherUser)),
      );
      emit(ChatRoomNavigateSuccessState(event.currentUser, event.otherUser));
    } catch (e) {
      emit(ChatRoomNavigateFailureState(e.toString()));
    }
  }

  FutureOr<void> _chatBackClickEvent(
      ChatBackClickEvent event, Emitter<HomeState> emit) {
    emit(ChatRoomToHomeNavigateState());
  }

  FutureOr<void> _sendMessageEvent(
      SendMessageEvent event, Emitter<HomeState> emit) async {
    try {
      emit(SendMessageLoadingState());
      final res =
          await _sendMessage.call(SendMessageParams(event.uid, event.message));
      res.fold(
        (l) => emit(SendMessageFailureState(l.msg)),
        (r) => emit(SendMessageSuccessState()),
      );
    } catch (e) {
      emit(SendMessageFailureState(e.toString()));
    }
  }

  FutureOr<void> _getChatMessagesEvent(
      GetChatMessagesEvent event, Emitter<HomeState> emit) async {
    emit(ChatMessagesListLoadingState());
    try {
      final res =
          await _getChatMessages.call(GetMessageParams(event.otherUser.id));
      res.fold(
        (l) => emit(ChatMessagesListFailureState(l.msg)),
        (r) {
          final List<ChatMessage> result = r.messages!.map(
            (m) {
              return ChatMessage(
                  user: event.currentUser.id == m.senderID
                      ? event.currentUser
                      : event.otherUser,
                  text: m.content!,
                  createdAt: m.sentAt!.toDate());
            },
          ).toList();
          result.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
          );
          emit(ChatMessagesListSuccessState(result));
        },
      );
    } catch (e) {
      emit(ChatMessagesListFailureState(e.toString()));
    }
  }
}
