import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitchen_mate/models/meals_user.dart';
import 'package:kitchen_mate/services/meals_service.dart';
import 'package:kitchen_mate/screens/the_meal.dart';

class WeekDays extends StatefulWidget {
  static const String id = 'days_of_week';
  final MealsUserArguement weekNameArg;
  WeekDays({this.weekNameArg});
  @override
  _WeekDaysState createState() => _WeekDaysState();
}

class _WeekDaysState extends State<WeekDays> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: <Widget>[
                Text(widget.weekNameArg.weekName),
                Row(
                  children: [
                    Text(
                      DateFormat.MMMMd()
                          .format(widget.weekNameArg.startingDate),
                    ),
                    Text(' - '),
                    Text(DateFormat.MMMMd().format(widget
                        .weekNameArg.startingDate
                        .add(Duration(days: 6)))),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: MealsService.email(
                    email: widget.weekNameArg.email,
                    startingDate: widget.weekNameArg.startingDate,
                    week: widget.weekNameArg.weekName)
                .listDay,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data.documents != null) {
                var dayList = snapshot.data.documents;
                // print(dayList);

                return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(7, (index) {
                      String day=DateFormat('EEEE')
                              .format(dayList[index]['timeStampDay'].toDate()).toString();
                      String date=DateFormat.MMMMd().format(
                                    dayList[index]['timeStampDay'].toDate()).toString();
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>ShowMyMeal(Meal(email:widget.weekNameArg.email,day:day,date:dayList[index]['timeStampDay'].toDate(),weekName: widget.weekNameArg.weekName))));
                        },
                                              child: Card(
                            child: ListTile(
                          title: Text(day),
                          subtitle: Text(date,
                            ))),
                      );
                    }));
              } else {
                return Container();
              }
            }));
  }
}