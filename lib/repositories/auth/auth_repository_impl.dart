import 'package:firebase_auth/firebase_auth.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  getCurrentUid() {
    final User? user = auth.currentUser;
    final uid = user!.uid.toString();
    return uid;
  }
}
