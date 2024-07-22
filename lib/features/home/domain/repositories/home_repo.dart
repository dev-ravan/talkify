import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/chat_mod.dart';
import 'package:talkify/features/home/data/model/message_mod.dart';
import 'package:talkify/features/home/data/model/user_model.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<Either<Failure, List<UserModel>>> getUserList();
  Future<Either<Failure, bool>> createChatRoom({
    required String uid,
  });
  Future<Either<Failure, bool>> sendMessage({
    required String uid,
    required Message message,
  });
  Future<Either<Failure, Chat>> getChatMessages({
    required String uid,
  });
}
