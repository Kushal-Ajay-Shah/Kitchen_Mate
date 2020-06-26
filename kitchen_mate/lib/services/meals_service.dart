import 'package:cloud_firestore/cloud_firestore.dart';

class MealsService {
  CollectionReference mealsUserRef;
  String emailId;
  String weekName;
  DateTime selectedDate;
  MealsService.email({email, week, startingDate}){
    emailId = email;
    weekName = week;
    selectedDate = startingDate;
    mealsUserRef = Firestore.instance
        .collection('kitchen')
        .document(email).collection('mealsplanner');
  }

// Week List
  Future <void> updateWeek({timeStampWeek}) async {
    return await mealsUserRef.document(weekName).setData({
      'weekName' : weekName,
      'startingDate' : selectedDate,
      'timeStampWeek' : timeStampWeek,
    });
  } 

  Stream<QuerySnapshot> get listWeek {
    return mealsUserRef.orderBy('timeStampWeek').snapshots();
  }

  Future <void> deleteWeek() async {
    return await mealsUserRef.document(weekName).delete();
  }
}