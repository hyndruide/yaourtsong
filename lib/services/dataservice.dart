import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/userdata.dart';

class DataService {
  final String? uid;
  DataService({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection("yaourtuser");

  Future<void> updateUser(UserData user) async {
    // Call the user's CollectionReference to add a new user
    return await users
        .doc(user.uid)
        .set({'pseudo': user.pseudo, 'age': user.age, 'avatar': user.avatar})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  UserData _userdatafromsnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!,
        pseudo: snapshot.data()!['pseudo'],
        age: snapshot.data()!['age'],
        avatar: snapshot.data()!['avatar']);
  }

  Stream<UserData> get userData {
    return users.doc(uid).snapshots().map(_userdatafromsnapshot);
  }
}
