import 'package:flutter/material.dart';

class MealsPlanner extends StatefulWidget {
  static const String id = 'meals_planner';
  @override
  _MealsPlanner createState() => _MealsPlanner();
}

class _MealsPlanner extends State<MealsPlanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Meals Planner'),
        backgroundColor: Colors.lime,
        elevation: 0.0,
      ),
    );
  }
}