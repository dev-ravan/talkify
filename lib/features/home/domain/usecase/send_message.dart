import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/core/usecase/usecase.dart';
import 'package:talkify/features/home/data/model/message_mod.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';

class SendMessage implements UseCase<bool, SendMessageParams> {
  final HomeRepository homeRepository;
  SendMessage(this.homeRepository);
  @override
  Future<Either<Failure, bool>> call(SendMessageParams params) async {
    return await homeRepository.sendMessage(
        uid: params.uid, message: params.message);
  }
}

class SendMessageParams {
  final String uid;
  final Message message;
  SendMessageParams(this.uid, this.message);
}
