import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitchen_mate/models/meals_user.dart';

import 'package:kitchen_mate/models/user_email_arg.dart';
import 'package:kitchen_mate/screens/days_of_week.dart';
import 'package:kitchen_mate/services/meals_service.dart';

class MealsPlanner extends StatefulWidget {
  static const String id = 'meals_planner';
  @override
  _MealsPlanner createState() => _MealsPlanner();
}

class _MealsPlanner extends State<MealsPlanner> {
  DateTime selectedDate;
  String weekName;

  Future<Null> _presentDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final UserEmail userEmail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Meals Planner'),
        backgroundColor: Colors.lime,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Add Week',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 25.0,
                        ),
                      ),
                      TextField(
                        cursorColor: Colors.lightGreen,
                        decoration: InputDecoration(
                          hintText: 'Add Week Name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lime),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        onChanged: (String value) {
                          weekName = value;
                        },
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(selectedDate == null
                                    ? 'No Date choosen!'
                                    : 'Starting Date : ${DateFormat.yMMMMd().format(selectedDate)}')),
                            FlatButton(
                              onPressed: _presentDatePicker,
                              child: Text(
                                'Choose Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              textColor: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.lightGreen,
                        onPressed: () async {
                          if (weekName != null && selectedDate != null) {
                            DateTime weekDayTime = DateTime.now();
                            await MealsService.email(
                                    email: userEmail.email,
                                    week: weekName,
                                    startingDate: selectedDate)
                                .updateWeek(timeStampWeek: weekDayTime);
                            Navigator.of(context).pop();
                            await MealsService.email(
                                    email: userEmail.email,
                                    week: weekName,
                                    startingDate: selectedDate)
                                .updateWeekDays(timeStampWeek: weekDayTime);
                          }
                        },
                        child:
                            Text("ADD", style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: MealsService.email(
          email: userEmail.email,
        ).listWeek,
        builder: (context, snapshot) {
          if (snapshot.data != null &&
              snapshot.data.documents != null &&
              snapshot.data.documents.length != 0) {
            var weekList = snapshot.data.documents;
            return ListView.builder(
                itemCount: weekList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WeekDays(
                                weekNameArg: MealsUserArguement(
                                  email: userEmail.email,
                                  weekName: weekList[index]['weekName'],
                                  startingDate:
                                      weekList[index]['startingDate'].toDate(),
                                ),
                              )));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(weekList[index]['weekName']),
                        subtitle: Row(
                          children: <Widget>[
                            Text(DateFormat.MMMMd().format(
                                weekList[index]['startingDate'].toDate())),
                            Text(' - '),
                            Text(DateFormat.MMMMd().format(weekList[index]
                                    ['startingDate']
                                .toDate()
                                .add(Duration(days: 6)))),
                          ],
                        ),
                        trailing: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Icon(
                            Icons.clear,
                            color: Colors.lightGreen,
                          ),
                          onPressed: () async {
                            print('hi,in the meals planner');
                            await MealsService.email(
                                    email: userEmail.email,
                                    week: weekList[index]['weekName'],
                                    startingDate: weekList[index]
                                            ['startingDate']
                                        .toDate())
                                .deleteWeek(weekList[index]['weekName']);
                          },
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Container(
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add Week here',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.lightGreen,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.lightGreen,
                        size: 45.0,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
