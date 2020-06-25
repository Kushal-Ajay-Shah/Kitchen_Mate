import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String listHead = '';
  String id;
  DocumentSnapshot newUser;
  CollectionReference userRef;
  CollectionReference finalRef;
  DatabaseService();
  DatabaseService.onlyEmail({this.id});
  DatabaseService.email({email, p}) {
    id = email;
    listHead = p;
    userRef = Firestore.instance
        .collection('kitchen')
        .document(email)
        .collection('shopping');
  }
  //Initialize Doc
  initializeDoc()async{
    return await Firestore.instance.collection('kitchen').document(id).setData({'user id':id});
  }
  checkDoc()async{
    newUser=await Firestore.instance.collection('kitchen').document(id).get();
    if(!newUser.exists){
      return await newUser.reference.setData({'user id':id});
    }
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
      'contributor':id,
      'timeStampListHead': timeStampListHead,
    });
  }

  Future<void> deleteList() async {
    return userRef.document(listHead).delete();
  }
  //rooms
  addContributor(anotherUser,DateTime timeStampListHead )async{
    newUser=await Firestore.instance.collection('kitchen').document(anotherUser).get();
    if(newUser.exists){
      await Firestore.instance.collection('rooms').document(listHead).setData({
      'admin':id,
      'users':FieldValue.arrayUnion([id,anotherUser]),},merge: true);
      return Firestore.instance.collection('kitchen').document(anotherUser).collection('shopping').document(listHead).setData({
        'timeStampListHead':timeStampListHead,
        'contributor':id,
        'tittle':listHead,
      });
    }
    else{
      return 'User does not exist';
    }
  }
}
