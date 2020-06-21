import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_mate/models/list_name.dart';
import 'package:provider/provider.dart';
import '../../services/data.dart';

class View extends StatefulWidget {
  final ShoppingListNameArg user;

  @override
  _ViewState createState() => _ViewState();
  View(this.user);
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<DocumentSnapshot>(context);
    if (list != null && list.data != null && list.data['boat'] != null) {
      print(list.data['boat']);
      print(list.data['totalToBeSpent']);
      return list.data == null
          ? Container()
          : ListView.builder(
              itemCount: list.data['boat'].length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                      leading: Checkbox(
                          value: list.data['boat'][index]['isChecked'],
                          onChanged: (value) async {
                            await DatabaseService.email(
                                    email: widget.user.email,
                                    p: widget.user.tittle).deleteItem(itemName: list.data['boat'][index]['itemName'], isChecked:list.data['boat'][index]['isChecked'], price: list.data['boat'][index]['price'] );

                            await DatabaseService.email(
                                    email: widget.user.email,
                                    p: widget.user.tittle)
                                .toggleCheckbox(
                                    itemName: list.data['boat'][index]['itemName'],
                                    isChecked: !list.data['boat'][index]['isChecked'],
                                    price: list.data['boat'][index]['price']);
                          }),
                      title: Text(list.data['boat'][index]['itemName']),
                      trailing: Text('₹ ${list.data['boat'][index]['price']}'),),
                );
              });
    } else {
      return Container();
    }
  }
}
