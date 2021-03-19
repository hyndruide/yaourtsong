import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yaourtsong/screens/authenticate/authenticate.dart';
import 'package:yaourtsong/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    bool isConnected = user != null;
    return isConnected ? Home() : Authenticate();
  }
}
