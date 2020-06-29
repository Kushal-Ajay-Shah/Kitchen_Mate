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
  String image;
  String mealtitle;
  Color textColor;
  Color textField;
  Color buttonColor;

  @override
  void initState() {
    super.initState();
    if (widget.number == 1) {
      _breakfastController.text = widget.prevMeals;
      image = 'assets/blur-bread-breakfast-cake-397913.jpg';
      buttonColor = Colors.black12;
      textColor = Colors.black;
      textField = Colors.black;
      mealtitle = 'Breakfast';
    } else if (widget.number == 2) {
      _lunchController.text = widget.prevMeals;
      image = 'assets/buffet-315691_1280.jpg';
      textColor = Colors.black;
      textField = Colors.black;
      buttonColor = Colors.white38;
      mealtitle = 'Lunch';
    } else if (widget.number == 3) {
      _snackController.text = widget.prevMeals;
      image = 'assets/close-up-of-coffee-cup-on-table-312418.jpg';
      textColor = Colors.white;
      textField = Colors.white;
      buttonColor = Colors.white24;
      mealtitle = 'Snacks';
    } else if (widget.number == 4) {
      _dinnerController.text = widget.prevMeals;
      image = 'assets/pizza-3007395_1920.jpg';
      textColor = Colors.white;
      buttonColor = Colors.white38;
      textField = Colors.black;
      mealtitle = 'Dinner';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/9118.jpg'), fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              mealtitle,
              style: TextStyle(
                fontSize: 24,
                color: textColor,
              ),
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: null,
        controller: finalController,
        decoration: InputDecoration(
            border: InputBorder.none, filled: true, fillColor: buttonColor),
        cursorColor: Colors.black,
        autofocus: true,
        style: TextStyle(
          fontSize: 18.0,
          color: textField,
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text(
        'Save',
        style: TextStyle(color: textColor),
      ),
      color: buttonColor,
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
    );
  }
}
