import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkify/core/error/exception.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
}
