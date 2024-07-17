import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    required File photo,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
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
  Future<String> registerUser({
    required String name,
    required String email,
    required String password,
    required File photo,
  }) async {
    // Generate a random id
    final userId = randomAlphaNumeric(7);

    // Create a user name using available mail id
    final userName = email.replaceAll("@gmail.com", "");

    try {
      // First add user with email and password
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If user added
      if (credential.user != null) {
        // Add image to storage
        Reference reference = _storage
            .ref()
            .child("images/${DateTime.now().microsecondsSinceEpoch}.png");
        await reference.putFile(photo);

        // Get download url
        String imgUrl = await reference.getDownloadURL();

        // Map of user info with the updated image URL
        Map<String, dynamic> userInfo = {
          "id": userId,
          "name": name,
          "userName": userName,
          "email": email,
          "password": password,
          "photo": imgUrl
        };

        // Add the user info to Firestore
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
