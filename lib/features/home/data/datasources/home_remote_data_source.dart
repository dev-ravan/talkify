import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'dart:developer' as developer;

abstract interface class HomeRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<List<UserModel>> getUserList();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> getUserList() async {
    try {
      CollectionReference users =
          _firestore.collection('users').withConverter<UserModel>(
                fromFirestore: (snapshot, _) =>
                    UserModel.fromJson(snapshot.data()!),
                toFirestore: (user, _) => user.toJson(),
              );

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception("No user currently signed in");
      }

      final querySnapshot =
          await users.where("uid", isNotEqualTo: currentUser.uid).get();

      final usersList = querySnapshot.docs.map((doc) {
        return doc.data() as UserModel;
      }).toList();

      return usersList;
    } on FirebaseAuthException catch (e) {
      developer.log("FirebaseAuth error: ${e.message}", error: e);
      throw Failure("Authentication error: ${e.message}");
    } on FirebaseException catch (e) {
      developer.log("Firestore error: ${e.message}", error: e);
      throw Failure("Database error: ${e.message}");
    } catch (e) {
      developer.log("Unexpected error", error: e);
      throw Failure("An unexpected error occurred: $e");
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception("No user currently signed in");
      }
      final userData =
          await _firestore.collection("users").doc(currentUser.uid).get();
      if (!userData.exists) {
        throw Failure("User document not found");
      }
      return UserModel.fromJson(userData.data()!);
    } on FirebaseAuthException catch (e) {
      developer.log("FirebaseAuth error: ${e.message}", error: e);
      throw Failure("Authentication error: ${e.message}");
    } on FirebaseException catch (e) {
      developer.log("Firestore error: ${e.message}", error: e);
      throw Failure("Database error: ${e.message}");
    } catch (e) {
      developer.log("Unexpected error", error: e);
      throw Failure("An unexpected error occurred: $e");
    }
  }
}
