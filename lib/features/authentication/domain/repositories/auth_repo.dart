import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
