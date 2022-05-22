import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService extends StatelessWidget {
  AuthService({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  Future signOut() async {
    try {
      print('sign out complete');
      return await _auth.signOut();
    } catch (e) {
      print('sign out failed');
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
