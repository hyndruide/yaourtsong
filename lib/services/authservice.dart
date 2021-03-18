import 'package:firebase_auth/firebase_auth.dart';
import 'package:yaourtsong/models/userdata.dart';
import 'package:yaourtsong/services/dataservice.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  // GET UID
  Future<String> getCurrentUID() async {
    return _auth.currentUser!.uid;
  }

  Future signwithemail(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      UserData user = UserData(uid: userCredential.user!.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future registerwithemail(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserData user = UserData(uid: userCredential.user!.uid);
      await DataService(uid: user.uid).updateUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Future signauth2(email, password) async{
  //       try {
  //     await _auth.signInWith
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
