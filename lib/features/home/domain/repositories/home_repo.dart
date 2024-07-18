import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talkify/core/error/failure.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getUserList();
}
