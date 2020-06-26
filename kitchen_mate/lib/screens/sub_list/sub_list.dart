import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_mate/models/list_name.dart';
import '../../services/data.dart';

class SubList extends StatefulWidget {
  static const String id = 'sub_shopping_list';
  final ShoppingListNameArg listName;
  SubList({this.listName});
  @override
  _SubListState createState() {
    return _SubListState();
  } 
}

class _SubListState extends State<SubList> {
  String input = '';
  String anotherUser;
  double price = 0.0;
  double total = 0.0;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    totalSum(widget.listName);
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

  void totalSum(ShoppingListNameArg listName2) {
    DatabaseService.email(email: listName2.email, p: listName2.tittle)
        .itemList
        .listen((snapshot) {
      double tempTotal =
          snapshot.documents.fold(0.0, (tot, doc) => tot + doc.data['price']);
      setState(() {
        total = tempTotal;
      });
      print(total);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.listName.tittle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          FlatButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String err = '';
                  var text;
                  return StreamBuilder<DocumentSnapshot>(
                      stream: Firestore.instance
                          .collection('kitchen')
                          .document(widget.listName.email)
                          .collection('shopping')
                          .document(widget.listName.tittle)
                          .snapshots(),
                      builder: (context, snapshot) {
                        DocumentSnapshot doom = snapshot.data;
                        text = doom.data['users'];

                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            title: Text(
                              'Add User',
                              style: TextStyle(color: Colors.lightGreen),
                            ),
                            content: SingleChildScrollView(
                              child: Container(
                                height: 250,
                                child: Column(
                                  children: <Widget>[
                                    Text('Current Collaborators'),
                                    Container(
                                        height: 150,
                                        width: 360,
                                        child: ListView.builder(
                                            itemCount: text.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onDoubleTap: () =>
                                                    DatabaseService.email(
                                                            email:
                                                                widget.listName.email,
                                                            p: widget.listName.tittle)
                                                        .removeUserColab(
                                                            userId:
                                                                text[index]),
                                                child: Card(
                                                  child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.lightGreen,
                                                        child: Text(
                                                          text[index][0],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        text[index],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )),
                                                ),
                                              );
                                            })),
                                    Expanded(
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: Colors.lightGreen,
                                        decoration: InputDecoration(
                                            labelText: 'Contributor\'s Mail Id',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.lime),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green),
                                            )),
                                        onChanged: (String value) {
                                          anotherUser = value;
                                        },
                                      ),
                                    ),
                                    Text(
                                      err,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  if (anotherUser.isNotEmpty) {
                                    dynamic error = await DatabaseService.email(
                                            email: widget.listName.email,
                                            p: widget.listName.tittle)
                                        .addContributor(
                                            anotherUser, DateTime.now());
                                    if (error != null) {
                                      setState(() {
                                        err = error;
                                      });
                                    } else {
                                      setState(() {
                                        err = '';
                                        anotherUser = '';
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                child: Text(
                                  'add',
                                  style: TextStyle(color: Colors.lime),
                                ),
                              ),
                            ],
                          );
                        });
                      });
                },
              );
            },
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.white,
            ),
            label:
                Text('Colaborate Users', style: TextStyle(color: Colors.white)),
          ),
        ],
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
                                    email: widget.listName.email, p: widget.listName.tittle)
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              child: ListTile(
                title: Text(
                  'Total Amount',
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                ),
                trailing: Text(
                  '₹ $total',
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: DatabaseService.email(
                        email: widget.listName.email, p: widget.listName.tittle)
                    .itemList,
                builder: (context, snapshot) {
                  if (snapshot != null &&
                      snapshot.data != null &&
                      snapshot.data.documents != null) {
                    var itemList = snapshot.data.documents;
                    return ListView.builder(
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
                                              email: widget.listName.email,
                                              p: widget.listName.tittle)
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
                                      email: widget.listName.email, p: widget.listName.tittle)
                                  .deleteItem(
                                      itemName: itemList[index]['itemName']);
                            },
                          );
                        });
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
