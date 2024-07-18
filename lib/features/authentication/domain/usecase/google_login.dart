import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/utils/exports.dart';

class UserGoogleLogin {
  final AuthRepository authRepository;
  UserGoogleLogin(this.authRepository);
  Future<Either<Failure, String>> userGoogleLogin() async {
    return await authRepository.loginWithGoogle();
  }
}
