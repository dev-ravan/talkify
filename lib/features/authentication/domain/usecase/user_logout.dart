import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/utils/exports.dart';

class UserLogout {
  final AuthRepository authRepository;
  UserLogout(this.authRepository);
  Future<Either<Failure, bool>> logout() async {
    return await authRepository.logout();
  }
}
