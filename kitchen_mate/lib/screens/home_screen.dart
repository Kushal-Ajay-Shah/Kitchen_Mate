import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitchen_mate/screens/meals_planner.dart';
import 'package:kitchen_mate/screens/shopping_list.dart';
import 'package:kitchen_mate/components/rounded_button.dart';
import 'package:kitchen_mate/screens/welcome_screen.dart';

FirebaseUser loggedInUser;

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit Kitchen Mate?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
          appBar: AppBar(
            leading: new Container(),
            actions: <Widget>[
              FlatButton.icon(
                  label: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                    //print(loggedInUser.email);
                  }),
            ],
            title: Text('Kitchen Mate'),
            backgroundColor: Colors.lightGreen,
            elevation: 0.0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RoundedButton(
                    title: 'Shopping List',
                    onPressed: () {
                      Navigator.pushNamed(context, ShoppingList.id);
                    },
                    colour: Colors.limeAccent[700],
                  ),
                  RoundedButton(
                    title: 'Meals Planner',
                    onPressed: () {
                      Navigator.pushNamed(context, MealsPlanner.id);
                    },
                    colour: Colors.green,
                  ),
                ]),
          )),
    );
  }
}
