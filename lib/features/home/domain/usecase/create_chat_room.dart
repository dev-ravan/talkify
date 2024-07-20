import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/core/usecase/usecase.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';

class CreateChatRoom implements UseCase<bool, ChatRoomParams> {
  final HomeRepository homeRepository;

  CreateChatRoom(this.homeRepository);
  @override
  Future<Either<Failure, bool>> call(ChatRoomParams params) async {
    return await homeRepository.createChatRoom(uid: params.uid);
  }
}

class ChatRoomParams {
  final String uid;
  ChatRoomParams(this.uid);
}
