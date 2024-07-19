import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/user_model.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<Either<Failure, List<UserModel>>> getUserList();
}
