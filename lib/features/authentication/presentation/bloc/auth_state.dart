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

final class LoginToRegisterState extends AuthActionState {}

final class RegisterPickImgSuccessState extends AuthState {
  final File image;
  RegisterPickImgSuccessState(this.image);
}

final class RegisterPickImgLoadingState extends AuthActionState {}

final class RegisterPickImgFailureState extends AuthActionState {
  final String msg;
  RegisterPickImgFailureState(this.msg);
}

final class RegisterToLoginClickState extends AuthActionState {}
