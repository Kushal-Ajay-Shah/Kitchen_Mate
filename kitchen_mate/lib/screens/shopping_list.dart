import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_mate/models/list_name.dart';
import 'package:kitchen_mate/models/user_email_arg.dart';
import './sub_list/sub_list.dart';
import '../services/data.dart';

class ShoppingList extends StatefulWidget {
  static const String id = 'shopping_list';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  String input = '';
  String tittle = '';
  // final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    super.initState();
    // await getCurrentUser();
  }

  // Future getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser();
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget build(BuildContext context) {
    final UserEmail userEmail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Shopping List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightGreen,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Add a list',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    content: TextField(
                      cursorColor: Colors.lightGreen,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.lime),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await DatabaseService.email(
                                  email: userEmail.email, p: input)
                              .updateListNames(timeStampListHead: DateTime.now());
                          Navigator.of(context).pop();
                        },
                        child: Text("ADD",
                            style: TextStyle(color: Colors.lightGreen)),
                      )
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.lime,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: DatabaseService.email(email: userEmail.email, p: input)
                .listData,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data.documents != null) {
                var list = snapshot.data.documents;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: Key(list[index]['tittle']),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubList(listName: ShoppingListNameArg.withActualUser(
                                    tittle: list[index]['tittle'],
                                    email: list[index]['contributor'],actualUser: userEmail.email),)));
                          },
                          child: Card(
                            child: ListTile(title: Text(list[index]['tittle'])),
                          ),
                        ),
                        onDismissed: (left) async {
                          await DatabaseService.email(
                                  email: userEmail.email,
                                  p: list[index]['tittle']).deleteAllItems();
                          await DatabaseService.email(
                                  email: userEmail.email,
                                  p: list[index]['tittle'])
                              .deleteList();
                        },
                      );
                    });
              } else {
                return Container();
              }
            }));
  }
}