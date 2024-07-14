import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/core/usecase/usecase.dart';
import 'package:talkify/features/authentication/domain/repositories/auth_repo.dart';

class UserLogin implements UseCase<String, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({required this.email, required this.password});
}
