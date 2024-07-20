import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkify/core/error/failure.dart';
import 'package:talkify/features/home/data/model/chat_mod.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'dart:developer' as developer;

import 'package:talkify/utils/chat_room_id.dart';

abstract interface class HomeRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<List<UserModel>> getUserList();
  Future<bool> createChatRoom({
    required String uid,
  });
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

  @override
  Future<bool> createChatRoom({required String uid}) async {
    try {
      // Generate chat room id
      final String chatID =
          generateChatRoomId(id1: _firebaseAuth.currentUser!.uid, id2: uid);
      // Get chat collection
      final CollectionReference chatsCollection =
          _firestore.collection("chats").withConverter<Chat>(
                fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
                toFirestore: (chat, _) => chat.toJson(),
              );
      // Check chat already exists or not
      final result = await chatsCollection.doc(chatID).get();

      if (!result.exists) {
        // Add chat model
        final chat = Chat(
            id: chatID,
            participants: [_firebaseAuth.currentUser!.uid, uid],
            messages: []);
        await chatsCollection.doc(chatID).set(chat);
        return true;
      }
      return false;
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
