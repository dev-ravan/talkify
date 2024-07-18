import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/exception.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/datasources/home_remote_data_source.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, Stream<QuerySnapshot<UserModel>>>>
      getUserList() async {
    try {
      final userList = homeRemoteDataSource.getUserList();
      return right(userList);
    } on ServerException catch (e) {
      return left(Failure(e.msg));
    }
  }
}
