import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/meals_user.dart';

class ShowMyMeal extends StatefulWidget {
  final Meal meal;
  @override
  _ShowMyMealState createState() => _ShowMyMealState();
  ShowMyMeal(this.meal);
}

class _ShowMyMealState extends State<ShowMyMeal> {
  bool edit = false;
  final TextEditingController breakfast = TextEditingController();
  final TextEditingController lunch = TextEditingController();
  final TextEditingController snacks = TextEditingController();
  final TextEditingController dinner = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Column(children: <Widget>[
        ListTile(
          title: Expanded(
              child: Text(
            widget.meal.weekName,
            style: TextStyle(color: Colors.white),
          )),
          subtitle: Text(
            widget.meal.day,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Text(widget.meal.date),
        )
      ]),
    );
    return Scaffold(
        appBar: appBar,
        body: StreamBuilder<DocumentSnapshot>(builder: (context, snapshot) {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(9, 0, 9, 0),
                    alignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Breakfast',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightGreen[700],
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: breakfast,
                            style: TextStyle(fontSize: 15),
                            cursorColor: Colors.lightGreen,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.lightGreen),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(9, 0, 9, 0),
                    alignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Lunch',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightGreen[700],
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: lunch,
                            style: TextStyle(fontSize: 15),
                            cursorColor: Colors.lightGreen,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.lightGreen),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(9, 0, 9, 0),
                    alignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Snacks',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightGreen[700],
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: snacks,
                            style: TextStyle(fontSize: 15),
                            cursorColor: Colors.lightGreen,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.lightGreen),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(9, 0, 9, 0),
                    alignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Dinner',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightGreen[700],
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: dinner,
                            style: TextStyle(fontSize: 15),
                            cursorColor: Colors.lightGreen,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.lightGreen),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
