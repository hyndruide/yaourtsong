import 'package:flutter/material.dart';
import 'package:yaourtsong/services/authservice.dart';

class Signin extends StatefulWidget {
  final Function toggleview;
  Signin({@required this.toggleview});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Votre email',
                    labelText: 'Email : ',
                  ),
                  onChanged: (val) {},
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    hintText: 'Votre mot de passe',
                    labelText: 'Password : ',
                  ),
                  obscureText: true,
                  onChanged: (val) {},
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Connection',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await _auth.signwithemail(
                          _emailController.text, _passwordController.text);
                    }),
                RaisedButton(
                    color: Colors.grey[400],
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    onPressed: () async {
                      widget.toggleview();
                      print("S'inscrire");
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
