class MealsUserArguement {
  String email;
  DateTime startingDate;
  String weekName;

  MealsUserArguement({this.email, this.startingDate, this.weekName});
}
class Meal{
  String email;
  String day;
  DateTime date;
  String weekName;
  Meal({this.email,this.weekName,this.date,this.day});
}