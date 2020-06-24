import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String listHead = '';
  String id;
  CollectionReference userRef;
  DocumentSnapshot newContributor;
  // CollectionReference finalRef;
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
      {String itemName,
      bool isChecked,
      double price,
      DateTime timestamp}) async {
    return await userRef
        .document(listHead)
        .collection('items')
        .document(itemName)
        .setData({
      'itemName': itemName,
      'isChecked': isChecked,
      'price': price,
      'timestamp': timestamp,
    });
  }

  Stream<DocumentSnapshot> get datas {
    return userRef.document(listHead).snapshots();
  }

  Stream<QuerySnapshot> get itemList {
    return userRef
        .document(listHead)
        .collection('items')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<void> toggleCheckbox(
      {String itemName, bool isChecked, double price}) async {
    return await userRef
        .document(listHead)
        .collection('items')
        .document(itemName)
        .updateData({
      'isChecked': !isChecked,
    });
  }

  Future<void> deleteItem(
      {String itemName}) async {
    return await userRef
        .document(listHead)
        .collection('items')
        .document(itemName)
        .delete();
  }

  Future<void> deleteAllItems() async {
    return await userRef
        .document(listHead)
        .collection('items')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

  //mainlist
  Stream<QuerySnapshot> get listData {
    return userRef.orderBy('timeStampListHead').snapshots();
  }

  Future<void> updateListNames({DateTime timeStampListHead}) async {
    return await userRef.document(listHead).setData({
      'tittle': listHead,
      'timeStampListHead' : timeStampListHead,
      'contributor':id,

    });
  }

  Future<void> deleteList() async {
    return userRef.document(listHead).delete();
  }
  //Rooms
  Future<void> addContributor({anotherUser,DateTime timeStampListHead})async{
    newContributor=await Firestore.instance.collection('kitchen').document(anotherUser).get();
    if(newContributor.exists){
      return newContributor.reference.collection('shopping').document(listHead).setData({
        'contributor':id,
        'tittle':listHead,
        'timeStampListHead':timeStampListHead,
      });

    }
  }
}
