part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingStete extends HomeState {}

final class HomeSuccessState extends HomeState {
  final List<UserModel> usersList;
  final UserModel user;
  HomeSuccessState(this.usersList, this.user);
}

final class HomeFailureStete extends HomeState {
  final String error;
  HomeFailureStete(this.error);
}

final class LogoutLoadingStete extends HomeState {}

final class LogoutSuccessState extends HomeActionState {
  final bool isLogout;
  LogoutSuccessState(this.isLogout);
}

final class LogoutFailureStete extends HomeActionState {
  final String error;
  LogoutFailureStete(this.error);
}

final class ChatRoomNavigateSuccessState extends HomeActionState {
  final UserModel user;
  ChatRoomNavigateSuccessState(this.user);
}

final class ChatRoomToHomeNavigateState extends HomeActionState {}

final class ChatRoomNavigateFailureState extends HomeActionState {
  final String error;
  ChatRoomNavigateFailureState(this.error);
}
