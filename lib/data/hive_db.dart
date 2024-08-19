import 'package:hive/hive.dart';
import 'package:tracky/models/expense_item.dart';

class HiveDB{
  //reference to box 
   final _box=Hive.box('expense_data');

  //write data
  void saveData(List<ExpenseItem> allExpenses){
   
        List<List<dynamic>> allExpensesFormatted=[];

        for (var e in allExpenses){
                List<dynamic> exp=[
                  e.name,e.amount,e.dateTime
                    ];
                allExpensesFormatted.add(exp);
              }
              print('--------------------------------------------------------------------------->$allExpensesFormatted');

        _box.put('ALL_EXPENSES',allExpensesFormatted);

  }


  //read data
  List<ExpenseItem> readData(){
  

  List savedExpenses=_box.get('ALL_EXPENSES')??[];
  print("----------------------------------------------------------------------------->$savedExpenses");
  List<ExpenseItem> allExpenses=[];
  
  for(int i=0;i<savedExpenses.length;i++){
    String name=savedExpenses[i][0];
    String amount=savedExpenses[i][1];
    DateTime dateTime=savedExpenses[i][2];

    ExpenseItem expense=ExpenseItem(name: name, amount: amount, dateTime: dateTime);
    allExpenses.add(expense);
  }
  return allExpenses;

  }

}