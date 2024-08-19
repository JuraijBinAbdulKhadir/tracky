import 'package:flutter/material.dart';
import 'package:tracky/data/hive_db.dart';
import 'package:tracky/models/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  List<ExpenseItem> overallExpense =[];

//get all
  List<ExpenseItem> getExpense(){
    return overallExpense;
  }

//prepare display
final db=HiveDB();
void prepareData(){
 if(db.readData().isNotEmpty){
  overallExpense=db.readData();
 }
}

//add new
  void addNewExpense(ExpenseItem newExpense ){
 overallExpense.add(newExpense);
 notifyListeners();
 db.saveData(overallExpense);
  }


//delete one
void deleteExpense(ExpenseItem expense){
overallExpense.remove(expense);
notifyListeners();
db.saveData(overallExpense);
}

//day name
String getDayName(DateTime dateTime){
  switch(dateTime.weekday){
    case 1:return 'Mon';
    case 2:return 'Tue';
    case 3:return 'Wed';
    case 4:return 'Thu';
    case 5:return 'Fri';
    case 6:return 'Sat';
    case 7:return 'Sun';
    default: return '';
    }
}

//start of week 
DateTime? startOfWeek(){
  DateTime? startweek;
  DateTime today=DateTime.now();
  for(int i=0;i<7;i++){
    if(getDayName(today.subtract(Duration(days: i)))=='Sun'){
      startweek=today.subtract(Duration(days: i));
    }
  }
  return startweek;
}


//calculate daily summary
Map<String,double> calculateDailySummary(){

 Map<String,double> dailySummary={};

for (var expense in overallExpense){
  String date=converter(expense.dateTime);
  double amount=double.parse(expense.amount);

  if(dailySummary.containsKey(date)){
    double currentAmount=dailySummary[date]!;
    currentAmount+=amount;
    dailySummary[date]=currentAmount;
  }else{
    dailySummary.addAll({date:amount});
    }
  }
return dailySummary;
}


}



String converter(DateTime dateTime){

String year=dateTime.year.toString();

String month=dateTime.month.toString();
if(month.length==1){month='0$month';}

String day= dateTime.day.toString();
if(day.length==1){day='0$day';}

String yyyymmdd=year+month+day;
return yyyymmdd;
}