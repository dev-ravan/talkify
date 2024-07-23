part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent {}

final class HomeLogoutClickEvent extends HomeEvent {}

final class HomeChatUserClickEvent extends HomeEvent {
  final UserModel otherUser;
  final UserModel currentUser;

  HomeChatUserClickEvent(this.otherUser, this.currentUser);
}

final class ChatBackClickEvent extends HomeEvent {}

final class SendMessageEvent extends HomeEvent {
  final String uid;
  final Message message;
  SendMessageEvent(this.uid, {required this.message});
}

final class GetChatMessagesEvent extends HomeEvent {
  final ChatUser currentUser;
  final ChatUser otherUser;
  GetChatMessagesEvent({
    required this.currentUser,
    required this.otherUser,
  });
}
