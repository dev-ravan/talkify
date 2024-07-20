part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent {}

final class HomeLogoutClickEvent extends HomeEvent {}

final class HomeChatUserClickEvent extends HomeEvent {
  final UserModel user;

  HomeChatUserClickEvent(this.user);
}

final class ChatBackClickEvent extends HomeEvent {}
