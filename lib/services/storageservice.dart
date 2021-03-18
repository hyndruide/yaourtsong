import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage fs = FirebaseStorage.instance;
  Future<String> uploadAvatar(File file, userData) async {
    print(file.path);
    Reference avatarfolder =
        fs.ref().child('/Avatar').child(userData.uid + "-avatar.jpg");
    var link = await avatarfolder.putFile(file).then((storageTask) async {
      String link = await storageTask.ref.getDownloadURL();
      print(link);
      return link;
    });
    return link;
  }
}
