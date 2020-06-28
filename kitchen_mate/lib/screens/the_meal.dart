import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitchen_mate/screens/edit_meals.dart';
import 'package:kitchen_mate/services/meals_service.dart';

import '../models/meals_user.dart';

class ShowMyMeal extends StatefulWidget {
  final Meal meal;
  @override
  _ShowMyMealState createState() => _ShowMyMealState();
  ShowMyMeal(this.meal);
}

class _ShowMyMealState extends State<ShowMyMeal> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.lightGreen,
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
          trailing:
              Text(DateFormat.MMMMd().format(widget.meal.date).toString()),
        )
      ]),
    );
    return Scaffold(
      appBar: appBar,
      body: StreamBuilder<DocumentSnapshot>(
        stream: MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName)
                .listMeal,
        builder: (context, snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    color: Colors.white,
                    elevation: 3,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Breakfast",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(snapshot.data['breakfast'] ?? 'Add Meal'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditMeals(meal: widget.meal, prevMeals: snapshot.data['breakfast'], number: 1,)));
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    color: Colors.white,
                    elevation: 3,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Lunch",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(snapshot.data['lunch'] ?? 'Add Meal'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditMeals(meal: widget.meal, prevMeals: snapshot.data['lunch'], number: 2,)));
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    color: Colors.white,
                    elevation: 3,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Snacks",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(snapshot.data['snacks'] ?? 'Add Meal'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditMeals(meal: widget.meal, prevMeals: snapshot.data['snacks'], number: 3,)));
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    color: Colors.white,
                    elevation: 3,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Dinner",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(snapshot.data['dinner'] ?? 'Add Meal'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditMeals(meal: widget.meal, prevMeals: snapshot.data['dinner'], number: 4,)));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
