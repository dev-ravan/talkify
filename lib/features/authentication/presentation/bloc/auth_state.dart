part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLetsGoSuccessState extends AuthActionState {
  final String msg;

  LoginLetsGoSuccessState(this.msg);
}

final class LoginLetsGoFailureState extends AuthActionState {
  final String error;

  LoginLetsGoFailureState(this.error);
}

final class LoginLetsGoLoadingState extends AuthState {}
