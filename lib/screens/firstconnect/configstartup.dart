import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yaourtsong/services/storageservice.dart';
import '../../services/dataservice.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class ConfigStartup extends StatefulWidget {
  @override
  _ConfigStartupState createState() => _ConfigStartupState();
}

class _ConfigStartupState extends State<ConfigStartup> {
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
    final user = Provider.of<User>(context);
    return StreamBuilder(
        stream: DataService(uid: user.uid).userData,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data;
            return Scaffold(
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
                              backgroundImage: (userData!.avatar == null
                                      ? AssetImage("assets/images/Doe.png")
                                      : NetworkImage(userData.avatar))
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
                      controller: _pseudocontroller..text = userData.pseudo,
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
                          "A la wannégene !",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
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
            return Container(child: Text("niée"));
          }
        });
  }
}
