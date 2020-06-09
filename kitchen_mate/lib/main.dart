import 'package:flutter/material.dart';

import 'package:kitchen_mate/screens/home_screen.dart';
import 'package:kitchen_mate/screens/login_screen.dart';
import 'package:kitchen_mate/screens/meals_planner.dart';
import 'package:kitchen_mate/screens/registration_screen.dart';
import 'package:kitchen_mate/screens/shopping_list.dart';
import 'package:kitchen_mate/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          Home.id: (context) => Home(),
          ShoppingList.id: (context) => ShoppingList(),
          MealsPlanner.id: (context) => MealsPlanner(),
        },
    );
  }
}

