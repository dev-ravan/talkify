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
