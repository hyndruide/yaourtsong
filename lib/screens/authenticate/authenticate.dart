import 'package:flutter/material.dart';
import 'package:yaourtsong/screens/authenticate/register.dart';
import 'package:yaourtsong/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isonsignin = true;
  toggleview() {
    setState(() {
      this.isonsignin = !this.isonsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.isonsignin
        ? Signin(toggleview: toggleview)
        : Register(toggleview: toggleview);
  }
}
