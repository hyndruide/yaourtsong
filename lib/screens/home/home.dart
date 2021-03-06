import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yaourtsong/services/dataservice.dart';
import 'package:yaourtsong/services/storageservice.dart';
import '../../models/userdata.dart';
import '../../services/authservice.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  TextEditingController _pseudocontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();
  StorageService _stserv = StorageService();
  late File _image;

  final picker = ImagePicker();

  Future getImage(userData, source) async {
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      userData.avatar = await _stserv.uploadAvatar(_image, userData);
      DataService(uid: userData.uid).updateUser(userData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DataService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data;
            if (userData!.pseudo == "newyahourtsinger") {
              return Scaffold(
                body: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Bienvenue !\n",
                        style: TextStyle(fontSize: 32.0),
                      ),
                      Container(
                        height: 150,
                        width: 110,
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                backgroundImage: (userData.avatar == null
                                        ? AssetImage("assets/images/Doe.png")
                                        : NetworkImage(userData.avatar!))
                                    as ImageProvider<Object>?,
                              ),
                            ),
                            Positioned(
                              bottom: 20.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(120),
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 5.0,
                                      offset: new Offset(2.0, 2.0),
                                    )
                                  ],
                                ),
                                height: 45,
                                width: 45,
                                child: Center(
                                    child: PopupMenuButton(
                                        onSelected: (dynamic value) {
                                          getImage(userData, value);
                                        },
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.white,
                                        ),
                                        itemBuilder: (buildcontext) {
                                          return [
                                            const PopupMenuItem(
                                              value: ImageSource.camera,
                                              child: Text('Prendre un photo'),
                                            ),
                                            const PopupMenuItem(
                                              value: ImageSource.gallery,
                                              child: Text('Dans la galerie'),
                                            ),
                                          ];
                                        })),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Text("choisissez un pseudo"),
                      TextFormField(
                        controller: _pseudocontroller..text = userData.pseudo!,
                      ),
                      SizedBox(height: 20.0),
                      Text("quel age avez vous ?"),
                      TextFormField(
                        controller: _agecontroller
                          ..text = (userData.age).toString(),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          child: Text(
                            "A la wann??gene !",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                          onPressed: () async {
                            userData.pseudo = _pseudocontroller.text;
                            userData.age = int.parse(_agecontroller.text);
                            DataService(uid: userData.uid).updateUser(userData);
                          }),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                  appBar: AppBar(title: Text(userData.pseudo!), actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    _auth.logout();
                    // Scaffold.of(context).showSnackBar(
                    //     const SnackBar(content: Text('This is a snackbar')));
                  },
                ),
              ]));
            }
          } else {
            return Container(child: Text("ni??e"));
          }
        });
  }
}
