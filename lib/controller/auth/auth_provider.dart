import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  late String? _uid;

  String? get uid => _uid;

  Future<void> init() async {
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    _uid = userCredential.user?.uid;
  }
}
