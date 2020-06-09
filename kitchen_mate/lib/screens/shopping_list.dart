import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  static const String id = 'shopping_list';
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Shopping List'),
        backgroundColor: Colors.lime,
        elevation: 0.0,
      ),
    );
  }
}