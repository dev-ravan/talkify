import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';

class GetUserList {
  final HomeRepository homeRepository;
  GetUserList(this.homeRepository);
  Future<Either<Failure, List<UserModel>>> getUserList() async {
    return await homeRepository.getUserList();
  }
}
