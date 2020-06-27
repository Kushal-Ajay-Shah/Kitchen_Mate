import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitchen_mate/services/meals_service.dart';

import '../models/meals_user.dart';

class ShowMyMeal extends StatefulWidget {
  final Meal meal;
  @override
  _ShowMyMealState createState() => _ShowMyMealState();
  ShowMyMeal(this.meal);
}

class _ShowMyMealState extends State<ShowMyMeal> {
  bool edit = false;
  TextEditingController breakfast = TextEditingController();
  TextEditingController lunch = TextEditingController();
  TextEditingController snacks = TextEditingController();
  TextEditingController dinner = TextEditingController();
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
              breakfast=new TextEditingController(text: snapshot.data['breakfast']);
              lunch=new TextEditingController(text: snapshot.data['lunch']);
              snacks=new TextEditingController(text: snapshot.data['snacks']);
              dinner=new TextEditingController(text: snapshot.data['dinner']);
              print(snapshot.data['breakfast']);
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
                                onChanged: (val){
                                  MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName).updateBreakfast(val);
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                controller: breakfast,
                                style: TextStyle(fontSize: 15),
                                cursorColor: Colors.lightGreen,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        8.0, 12.0, 8.0, 12.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.lightGreen),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
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
                                onChanged: (val){
                                  MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName).updateLunch(val);
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                controller: lunch,
                                style: TextStyle(fontSize: 15),
                                cursorColor: Colors.lightGreen,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        8.0, 12.0, 8.0, 12.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.lightGreen),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
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
                                onChanged: (val){
                                  MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName).updateSnacks(val);
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                controller: snacks,
                                style: TextStyle(fontSize: 15),
                                cursorColor: Colors.lightGreen,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        8.0, 12.0, 8.0, 12.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.lightGreen),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
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
                                onChanged: (val){
                                  MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName).updateDinner(val);
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                controller: dinner,
                                style: TextStyle(fontSize: 15),
                                cursorColor: Colors.lightGreen,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        8.0, 12.0, 8.0, 12.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.lightGreen),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
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
