import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/user_model.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, Stream<QuerySnapshot<UserModel>>>>
      getUserList();
}
