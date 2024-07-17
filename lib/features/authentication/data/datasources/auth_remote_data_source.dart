import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:talkify/core/error/exception.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<String> registerUser({
    required String name,
    required String email,
    required String password,
    required String photo,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user == null) {
        throw ServerException("User is null!");
      }
      return credential.user!.uid;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> registerUser(
      {required String name,
      required String email,
      required String password,
      required String photo}) async {
    final userId = randomAlphaNumeric(7);
    final userName = email.replaceAll("@gmail.com", "");
    Map<String, dynamic> userInfo = {
      "id": userId,
      "name": name,
      "userName": userName,
      "email": email,
      "password": password,
      "photo": photo
    };
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        await _firestore.collection("users").doc(userId).set(userInfo);
        return credential.user!.uid;
      } else {
        throw ServerException("User is null..!");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
