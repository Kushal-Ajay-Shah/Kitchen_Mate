import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/meals_user.dart';

class ShowMyMeal extends StatefulWidget {
  final Meal meal;
  @override
  _ShowMyMealState createState() => _ShowMyMealState();
  ShowMyMeal(this.meal);
}

class _ShowMyMealState extends State<ShowMyMeal> {
  bool edit = false;
  String breakfast = '';
  String lunch = '';
  String snacks = '';
  String dinner = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(children: <Widget>[
            ListTile(
              title: Expanded(child: Text(widget.meal.weekName)),
              subtitle: Text(widget.meal.day),
              trailing: Text(widget.meal.date),
            )
          ]),
          actions: [
            edit
                ? IconButton(
                    icon: Icon(Icons.done, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        edit = false;
                      });
                    })
                : Container()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              edit = true;
            });
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(builder: (context, snapshot) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: (MediaQuery.of(context).size.height-21) * 0.25,
                  // color: Colors.greenAccent,
                  child: Column(
                    children: [
                      Text('BreakFast'),
                      !edit
                          ? Text(breakfast)
                          : TextField(
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
                                setState(() {
                                  breakfast = value;
                                });
                              },
                            )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: (MediaQuery.of(context).size.height-21) * 0.25,

                  // color: Colors.cyan,
                  child: Column(
                    children: [
                      Text('lunch'),
                      !edit
                          ? Text(lunch)
                          : TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lime),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  lunch = value;
                                });
                              },
                            )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: (MediaQuery.of(context).size.height-21 )* 0.25,

                  // color: Colors.lime,
                  child: Column(
                    children: [
                      Text('Snacks'),
                      !edit
                          ? Text(snacks)
                          : TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lime),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  snacks = value;
                                });
                              },
                            )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: (MediaQuery.of(context).size.height-21) * 0.25,

                  // color: Colors.lightGreen,
                  child: Column(
                    children: [
                      Text('Dinner'),
                      !edit
                          ? Text(dinner)
                          : TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lime),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  dinner = value;
                                });
                              },
                            )
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
