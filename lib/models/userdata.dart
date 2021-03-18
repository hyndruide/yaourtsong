import 'package:flutter/cupertino.dart';

class UserData {
  final String? uid;
  UserData({required this.uid, this.age, this.pseudo, this.avatar});
  int? age;
  String? pseudo;
  String? avatar;
}
