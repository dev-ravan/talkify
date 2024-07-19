import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkify/core/error/exception.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/user_model.dart';

abstract interface class HomeRemoteDataSource {
 Stream<QuerySnapshot<UserModel>> getUserList();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
 Stream<QuerySnapshot<UserModel>> getUserList() {
    CollectionReference users = _firestore.collection('users');
    try {
      final userList = users
          .where("uid", isNotEqualTo: _firebaseAuth.currentUser!.uid)
          .snapshots() as Stream<QuerySnapshot<UserModel>>;
      return userList;
    }on ServerException  catch (e) {
      throw Failure(e.toString());
    }
  }
}
