part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginLetsGoButtonClickEvent extends AuthEvent {
  final String email;
  final String password;
  LoginLetsGoButtonClickEvent({required this.email, required this.password});
}

final class LoginGoogleClickEvent extends AuthEvent {}

final class LoginFacebookClickEvent extends AuthEvent {}

final class LoginCreateItClickEvent extends AuthEvent {}

final class LoginForgotPasswordClickEvent extends AuthEvent {}

final class LoginRememberMeCheckClickEvent extends AuthEvent {}

final class RegisterButtonClickEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final File photo;

  RegisterButtonClickEvent(
      {required this.name,
      required this.email,
      required this.password,
      required this.photo});
}

final class RegisterPickImgEvent extends AuthEvent {}

final class RegisterToLoginClickEvent extends AuthEvent {}
