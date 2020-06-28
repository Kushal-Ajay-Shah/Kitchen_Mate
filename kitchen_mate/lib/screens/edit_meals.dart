import 'package:flutter/material.dart';
import 'package:kitchen_mate/models/meals_user.dart';
import 'package:kitchen_mate/services/meals_service.dart';

class EditMeals extends StatefulWidget {
  final Meal meal;
  final String prevMeals;
  final int number;
  @override
  _EditMealsState createState() => _EditMealsState();
  EditMeals({this.meal, this.prevMeals, this.number});
}

class _EditMealsState extends State<EditMeals> {
  TextEditingController _breakfastController = new TextEditingController();
  TextEditingController _lunchController = new TextEditingController();
  TextEditingController _snackController = new TextEditingController();
  TextEditingController _dinnerController = new TextEditingController();
  TextEditingController finalController;
  String mealtitle;

  @override
  void initState() {
    super.initState();
    if (widget.number == 1) {
      _breakfastController.text = widget.prevMeals;
    } else if (widget.number == 2) {
      _lunchController.text = widget.prevMeals;
    } else if (widget.number == 3) {
      _snackController.text = widget.prevMeals;
    } else if (widget.number == 4) {
      _dinnerController.text = widget.prevMeals;
    }
    if (widget.number == 1) {
      mealtitle = 'Breakfast';
    } else if (widget.number == 2) {
      mealtitle = 'Lunch';
    } else if (widget.number == 3) {
      mealtitle = 'Snacks';
    } else if (widget.number == 4) {
      mealtitle = 'Dinner';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.lightGreen[200],
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              buildHeading(),
              buildMealsNotes(),
              buildSubmitButton(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildHeading() {
    return Material(
      color: Colors.lightGreen[200],
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                mealtitle,
                style: TextStyle(fontSize: 24,),
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }

  Widget buildMealsNotes() {
    if (widget.number == 1) {
      finalController = _breakfastController;
    } else if (widget.number == 2) {
      finalController = _lunchController;
    } else if (widget.number == 3) {
      finalController = _snackController;
    } else if (widget.number == 4) {
      finalController = _dinnerController;
    }
    return Material(
        color: Colors.lightGreen[200],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            maxLines: null,
            controller: finalController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            cursorColor: Colors.black,
            autofocus: true,
            style: TextStyle(fontSize: 18.0),
          ),
        ));
  }

  Widget buildSubmitButton() {
    return Material(
      color: Colors.lightGreen[200],
      child: RaisedButton(
        child: Text('Save'),
        color: Colors.lightGreen,
        onPressed: () async {
          if (widget.number == 1) {
            _breakfastController = finalController;
            await MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName)
                .updateBreakfast(_breakfastController.text);
          } else if (widget.number == 2) {
            _lunchController = finalController;
            await MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName)
                .updateLunch(_lunchController.text);
          } else if (widget.number == 3) {
            _snackController = finalController;
            await MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName)
                .updateSnacks(_snackController.text);
          } else if (widget.number == 4) {
            _dinnerController = finalController;
            await MealsService.email(
                    email: widget.meal.email,
                    startingDate: widget.meal.date,
                    dayT: widget.meal.day,
                    week: widget.meal.weekName)
                .updateDinner(_dinnerController.text);
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
