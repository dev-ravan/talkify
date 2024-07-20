import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:talkify/core/error/exception.dart';
import "package:path/path.dart" as p;

abstract interface class AuthRemoteDataSource {
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<String> loginWithGoogle();
  Future<String> registerUser({
    required String name,
    required String email,
    required String password,
    required File photo,
  });
  Future<bool> logout();
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

      if (credential.user != null) {
        return credential.user!.uid;
      }
      throw ServerException("User is null!");
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
    print(photo);

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
        Reference reference = _storage.ref().child(
            "images/${DateTime.now().microsecondsSinceEpoch}${p.extension(photo.path)}");
        await reference.putFile(photo);

        // Get download url
        String imgUrl = await reference.getDownloadURL();

        // Map of user info with the updated image URL
        Map<String, dynamic> userInfo = {
          "uid": credential.user!.uid,
          "name": name,
          "userName": userName,
          "email": email,
          "password": password,
          "photo": imgUrl
        };

        // Add the user info to Firestore
        await _firestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(userInfo);

        return credential.user!.uid;
      }
      throw ServerException("User is null..!");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> loginWithGoogle() async {
    try {
      // Add google provider
      final GoogleAuthProvider googleAuth = GoogleAuthProvider();

      // Get credential using google auth
      final credential = await _firebaseAuth.signInWithProvider(googleAuth);
      if (credential.user != null) {
        return credential.user!.uid;
      } else {
        throw ServerException("Un authorised user");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
