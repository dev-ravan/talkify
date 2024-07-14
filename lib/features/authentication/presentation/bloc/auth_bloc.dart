import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkify/features/authentication/domain/usecases/user_login.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  AuthBloc({required UserLogin userLogin})
      : _userLogin = userLogin,
        super(AuthInitial()) {
    on<LoginLetsGoButtonClickEvent>(_loginLetsGoButtonClickEvent);
  }

  FutureOr<void> _loginLetsGoButtonClickEvent(
      LoginLetsGoButtonClickEvent event, Emitter<AuthState> emit) async {
    emit(LoginLetsGoLoadingState());
    try {
      final res = await _userLogin.call(
        UserLoginParams(email: event.email, password: event.password),
      );
      res.fold((l) => emit(LoginLetsGoFailureState(l.msg)),
          (r) => emit(LoginLetsGoSuccessState(r)));
    } catch (e) {
      emit(LoginLetsGoFailureState(e.toString()));
    }
  }
}
