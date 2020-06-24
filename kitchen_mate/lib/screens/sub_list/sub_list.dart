import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_mate/models/list_name.dart';
import '../../services/data.dart';

class SubList extends StatefulWidget {
  static const String id = 'sub_shopping_list';
  @override
  _SubListState createState() => _SubListState();
}

class _SubListState extends State<SubList> {
  String input = '';
  String anotherUser;
  double price = 0.0;
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
    final ShoppingListNameArg listName =
        ModalRoute.of(context).settings.arguments;
    print(listName.email);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          listName.tittle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          FlatButton.icon(
            onPressed: () {
              // print("${widget.tittle}");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Add Contributor',
                        style: TextStyle(color: Colors.lightGreen),
                      ),
                      content: Container(
                        height: 60,
                        child: Column(
                          children: <Widget>[
                            TextField(
                              cursorColor: Colors.lightGreen,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Contributor',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.lime),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                              onChanged: (String value) {
                                anotherUser = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            if (anotherUser != '') {
                              await DatabaseService.email(
                                      email: listName.email, p: listName.tittle)
                                  .addContributor(
                                      anotherUser: anotherUser,
                                      timeStampListHead: DateTime.now());
                                      anotherUser='';
                              Navigator.of(context).pop();
                            } else {
                              anotherUser='';
                              return;
                            }
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(color: Colors.lightGreen),
                          ),
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.supervised_user_circle, color: Colors.green),
            label: Text(
              'Add Contributor',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
        backgroundColor: Colors.lime,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("${widget.tittle}");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Add item',
                    style: TextStyle(color: Colors.lightGreen),
                  ),
                  content: Container(
                    height: 180,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          cursorColor: Colors.lightGreen,
                          decoration: InputDecoration(
                              labelText: 'Item',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.lime),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              )),
                          onChanged: (String value) {
                            input = value;
                          },
                        ),
                        TextField(
                          cursorColor: Colors.lightGreen,
                          decoration: InputDecoration(
                              labelText: 'Price',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.lime),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              )),
                          onChanged: (String val) {
                            price = double.parse(val);
                          },
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () async {
                          if (input.isNotEmpty && price.toString().isNotEmpty) {
                            await DatabaseService.email(
                                    email: listName.email, p: listName.tittle)
                                .updateUserData(
                              itemName: input,
                              isChecked: false,
                              price: price,
                              timestamp: DateTime.now(),
                            );
                            price = 0.0;
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "ADD",
                          style: TextStyle(color: Colors.lightGreen),
                        ))
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
      body: StreamBuilder<QuerySnapshot>(
          stream:
              DatabaseService.email(email: listName.email, p: listName.tittle)
                  .itemList,
          builder: (context, snapshot) {
            if (snapshot != null &&
                snapshot.data != null &&
                snapshot.data.documents != null) {
              var itemList = snapshot.data.documents;
              return Container(
                height: 500,
                child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: Key(itemList[index]['itemName']),
                                              child: Card(
                          child: ListTile(
                            leading: Checkbox(
                                value: itemList[index]['isChecked'],
                                onChanged: (value) async {
                                  await DatabaseService.email(
                                          email: listName.email,
                                          p: listName.tittle)
                                      .toggleCheckbox(
                                    itemName: itemList[index]['itemName'],
                                    isChecked: itemList[index]['isChecked'],
                                  );
                                }),
                            title: Text(itemList[index]['itemName']),
                            trailing: Text('₹ ${itemList[index]['price']}'),
                          ),
                        ),
                        onDismissed: (left) async {
                          await DatabaseService.email(
                                          email: listName.email,
                                          p: listName.tittle).deleteItem(itemName: itemList[index]['itemName']);
                        },
                      );
                    }),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
