import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
    print(timeStampWeek.add(Duration(days:2)).day);
    for(int i=0;i<7;i++){
      DateTime temp=selectedDate.add(Duration(days:i));
      String dateFormat =DateFormat('EEEE').format(temp);
      print(dateFormat);
      await mealsUserRef.document(weekName).collection('days').document(dateFormat).setData({
        'timeStampDay':temp,
      });
    }
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
  //Day list
  Stream<QuerySnapshot> get listDay{
    return mealsUserRef.document(weekName).collection('days').orderBy('timeStampDay').snapshots();
  }
}