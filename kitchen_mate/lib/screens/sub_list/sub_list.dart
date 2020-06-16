
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_mate/models/list_name.dart';
import 'package:provider/provider.dart';
import '../../services/data.dart';
import './view_sublist.dart';

class SubList extends StatefulWidget {
  static const String id = 'sub_shopping_list';
  @override
  _SubListState createState() => _SubListState();
}
  

class _SubListState extends State<SubList> {
  String input='';
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
  final ShoppingListNameArg listName=ModalRoute.of(context).settings.arguments;
    
    return StreamProvider<DocumentSnapshot>.value(

          value: DatabaseService.email(email:listName.email,p:listName.tittle).datas,
          child: Scaffold(
          appBar: AppBar(
            title: Text(
              listName.tittle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.lime,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // print("${widget.tittle}");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('add Todo here'),
                      content: TextField(
                        onChanged: (String value) {
                          input = value;
                        },
                      ),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () async {
                              await DatabaseService.email(email:listName.email,p:listName.tittle).updateUserData(itemName: input);
                              Navigator.of(context).pop();
                              },
                            child: Text("ADD"))
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightGreen,
          ),
          body:View(listName),
          ),
    );
  }
}
