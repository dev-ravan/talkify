import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:talkify/utils/exports.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final ImagePicker _picker = ImagePicker();

  AuthBloc({required UserLogin userLogin})
      : _userLogin = userLogin,
        super(AuthInitial()) {
    on<LoginLetsGoButtonClickEvent>(_loginLetsGoButtonClickEvent);
    on<LoginCreateItClickEvent>(_loginCreateItClickEvent);
    on<RegisterPickImgEvent>(_registerPickImgEvent);
    on<RegisterToLoginClickEvent>(_registerToLoginClickEvent);
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
}
