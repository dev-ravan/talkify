import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/core/usecase/usecase.dart';
import 'package:talkify/features/authentication/domain/repositories/auth_repo.dart';

class UserRegister implements UseCase<String, UserRegisterParams> {
  final AuthRepository authRepository;
  UserRegister(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserRegisterParams params) async {
    return await authRepository.registerUser(
        name: params.name,
        email: params.email,
        password: params.password,
        photo: params.photo);
  }
}

final class UserRegisterParams {
  final String name;
  final String email;
  final String password;
  final File photo;

  UserRegisterParams(
      {required this.name,
      required this.email,
      required this.password,
      required this.photo});
}
