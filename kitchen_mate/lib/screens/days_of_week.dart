import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitchen_mate/models/meals_user.dart';

class WeekDays extends StatefulWidget {
  static const String id = 'days_of_week';
  final  MealsUserArguement weekNameArg;
  WeekDays({this.weekNameArg});
  @override
  _WeekDaysState createState() => _WeekDaysState();
}

class _WeekDaysState extends State<WeekDays> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(widget.weekNameArg.weekName),
            SizedBox(width: 27,),
            Text(DateFormat.MMMMd().format(widget.weekNameArg.startingDate)),
            Text(' - '),
            Text(DateFormat.MMMMd().format(widget.weekNameArg.startingDate.add(Duration(days: 6)))),
          ],
        ),

      ),
    );
  }
}