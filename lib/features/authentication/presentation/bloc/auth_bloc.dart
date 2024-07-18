import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:talkify/features/authentication/domain/usecase/google_login.dart';
import 'package:talkify/features/authentication/domain/usecase/user_register.dart';
import 'package:talkify/utils/exports.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserRegister _userRegister;
  final UserGoogleLogin _userGoogleLogin;
  final ImagePicker _picker = ImagePicker();

  AuthBloc(
      {required UserLogin userLogin,
      required UserRegister userRegister,
      required UserGoogleLogin userGoogleLogin})
      : _userLogin = userLogin,
        _userRegister = userRegister,
        _userGoogleLogin = userGoogleLogin,
        super(AuthInitial()) {
    on<LoginLetsGoButtonClickEvent>(_loginLetsGoButtonClickEvent);
    on<LoginGoogleClickEvent>(_loginGoogleClickEvent);
    on<LoginCreateItClickEvent>(_loginCreateItClickEvent);
    on<RegisterPickImgEvent>(_registerPickImgEvent);
    on<RegisterToLoginClickEvent>(_registerToLoginClickEvent);
    on<RegisterButtonClickEvent>(_registerButtonClickEvent);
  }

  FutureOr<void> _loginLetsGoButtonClickEvent(
      LoginLetsGoButtonClickEvent event, Emitter<AuthState> emit) async {
    emit(LoginLetsGoLoadingState());
    try {
      final res = await _userLogin.call(
        UserLoginParams(email: event.email, password: event.password),
      );
      return res.fold((l) => emit(LoginLetsGoFailureState(l.msg)),
          (r) => emit(LoginLetsGoSuccessState(r)));
    } catch (e) {
      emit(LoginLetsGoFailureState(e.toString()));
    }
  }

  FutureOr<void> _loginCreateItClickEvent(
      LoginCreateItClickEvent event, Emitter<AuthState> emit) {
    emit(LoginToRegisterState());
  }

  FutureOr<void> _registerPickImgEvent(
      RegisterPickImgEvent event, Emitter<AuthState> emit) async {
    emit(RegisterPickImgLoadingState());
    try {
      final XFile? pickedImg =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImg != null) {
        emit(RegisterPickImgSuccessState(File(pickedImg.path)));
      } else {
        emit(RegisterPickImgFailureState("No image selected!"));
      }
    } catch (e) {
      emit(RegisterPickImgFailureState(e.toString()));
    }
  }

  FutureOr<void> _registerToLoginClickEvent(
      RegisterToLoginClickEvent event, Emitter<AuthState> emit) {
    emit(RegisterToLoginClickState());
  }

  FutureOr<void> _registerButtonClickEvent(
      RegisterButtonClickEvent event, Emitter<AuthState> emit) async {
    emit(AuthRegisterLoadingState());
    try {
      final res = await _userRegister.call(
        UserRegisterParams(
            name: event.name,
            email: event.email,
            password: event.password,
            photo: event.photo),
      );
      res.fold(
        (l) => emit(AuthRegisterFailureState(l.msg)),
        (r) => emit(
          AuthRegisterSuccessState(r),
        ),
      );
    } catch (e) {
      emit(AuthRegisterFailureState(e.toString()));
    }
  }

  FutureOr<void> _loginGoogleClickEvent(
      LoginGoogleClickEvent event, Emitter<AuthState> emit) async {
    emit(LoginGoogleLoadingState());
    try {
      final res = await _userGoogleLogin.userGoogleLogin();
      res.fold(
        (l) => emit(LoginGoogleFailureState(l.msg)),
        (r) => emit(LoginGoogleSuccessState(r)),
      );
    } catch (e) {
      emit(LoginGoogleFailureState(e.toString()));
    }
  }
}
