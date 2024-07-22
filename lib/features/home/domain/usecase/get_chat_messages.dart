import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/core/usecase/usecase.dart';
import 'package:talkify/features/home/data/model/chat_mod.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';

class GetChatMessages implements UseCase<Chat, GetMessageParams> {
  final HomeRepository homeRepository;

  GetChatMessages(this.homeRepository);
  @override
  Future<Either<Failure, Chat>> call(GetMessageParams params) async {
    return await homeRepository.getChatMessages(uid: params.uid);
  }
}

class GetMessageParams {
  final String uid;
  GetMessageParams(this.uid);
}
