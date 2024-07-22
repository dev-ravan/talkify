import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/exception.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/datasources/home_remote_data_source.dart';
import 'package:talkify/features/home/data/model/chat_mod.dart';
import 'package:talkify/features/home/data/model/message_mod.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<UserModel>>> getUserList() async {
    try {
      final userList = await homeRemoteDataSource.getUserList();
      return right(userList);
    } on ServerException catch (e) {
      return left(Failure(e.msg));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final user = await homeRemoteDataSource.getCurrentUser();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.msg));
    }
  }

  @override
  Future<Either<Failure, bool>> createChatRoom({required String uid}) async {
    try {
      final result = await homeRemoteDataSource.createChatRoom(uid: uid);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.msg));
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage(
      {required String uid, required Message message}) async {
    try {
      final result =
          await homeRemoteDataSource.sendMessage(uid: uid, message: message);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.msg));
    }
  }

  @override
  Future<Either<Failure, Chat>> getChatMessages({required String uid}) async {
    try {
      final result = await homeRemoteDataSource.getChatMessages(uid: uid);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.msg));
    }
  }
}
