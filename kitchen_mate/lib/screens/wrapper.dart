import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kitchen_mate/screens/home_screen.dart';
import 'package:kitchen_mate/screens/welcome_screen.dart';
import 'package:kitchen_mate/models/user.dart';
class Wrapper extends StatelessWidget {
  static const String id = 'wrapper';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return WelcomeScreen();
    }else{
      return Home.email(user.email);
    }
  }
}