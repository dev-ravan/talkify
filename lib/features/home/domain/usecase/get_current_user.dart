import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';

class GetCurrentUser {
  final HomeRepository homeRepository;
  GetCurrentUser(this.homeRepository);
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    return homeRepository.getCurrentUser();
  }
}
