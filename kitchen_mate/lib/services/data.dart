import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String listHead = '';
  String id;
  CollectionReference userRef;
  DatabaseService();
  DatabaseService.email({email, p}) {
    id = email;
    listHead = p;
    userRef = Firestore.instance
        .collection('kitchen')
        .document(email)
        .collection('shopping');
  }
  //sublist
  Future<void> updateUserData(
      {String itemName, bool isChecked, double price}) async {
    return await userRef.document(listHead).setData({
      'boat': FieldValue.arrayUnion([
        {'itemName': itemName, 'isChecked': isChecked, 'price': price}
      ]),
    }, merge: true);
  }

  Stream<DocumentSnapshot> get datas {
    return userRef.document(listHead).snapshots();
  }

  Future<void> deleteItem(
      {String itemName, bool isChecked, double price}) async {
    return await userRef.document(listHead).updateData({
      'boat': FieldValue.arrayRemove([
        {'itemName': itemName, 'isChecked': isChecked, 'price': price}
      ]),
    });
  }

  Future<void> toggleCheckbox(
      {String itemName, bool isChecked, double price}) async {
    return await userRef.document(listHead).setData({
      'boat': FieldValue.arrayUnion([
        {'itemName': itemName, 'isChecked': isChecked, 'price': price}
      ]),
    }, merge: true);
  }

  //mainlist
  Stream<QuerySnapshot> get listData {
    return userRef.snapshots();
  }

  Future<void> updateListNames() async {
    return await userRef.document(listHead).setData({
      'tittle': listHead,
    });
  }

  Future<void> deleteList() async {
    return userRef.document(listHead).delete();
  }
}
