import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/exception.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:talkify/features/authentication/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final userId = await authRemoteDataSource.loginWithEmailPassword(
          email: email, password: password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.msg));
    }
  }
}
