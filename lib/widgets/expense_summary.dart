import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracky/data/expense_data.dart';
import 'package:tracky/widgets/bar_graph/bar_graph.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key,required this.startOfWeek});

  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ){
    double max=1000;
    List<double> values=[
      value.calculateDailySummary()[sunday]??0,
      value.calculateDailySummary()[monday]??0,
      value.calculateDailySummary()[tuesday]??0,
      value.calculateDailySummary()[wednesday]??0,
      value.calculateDailySummary()[thursday]??0,
      value.calculateDailySummary()[friday]??0,
      value.calculateDailySummary()[saturday]??0,
    ];
    values.sort();
    max=values.last *1.1;
    return max==0?1000:max;
  }

  String calculateWeekly(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ){
    double total=0;
    List<double> values=[
      value.calculateDailySummary()[sunday]??0,
      value.calculateDailySummary()[monday]??0,
      value.calculateDailySummary()[tuesday]??0,
      value.calculateDailySummary()[wednesday]??0,
      value.calculateDailySummary()[thursday]??0,
      value.calculateDailySummary()[friday]??0,
      value.calculateDailySummary()[saturday]??0,
    ];
    for(int i=0;i<values.length;i++){
      total+=values[i];
    }

    return total.toString();
    
  }

  @override
  Widget build(BuildContext context) {

    String sunday =converter(startOfWeek.add(const Duration(days: 0)));
    String monday =converter(startOfWeek.add(const Duration(days: 1)));
    String tuesday =converter(startOfWeek.add(const Duration(days: 2)));
    String wednesday =converter(startOfWeek.add(const Duration(days: 3)));
    String thursday =converter(startOfWeek.add(const Duration(days: 4)));
    String friday =converter(startOfWeek.add(const Duration(days: 5)));
    String saturday =converter(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => 
      Column(
        children: [
          Padding(
           padding: EdgeInsets.all(25),
           child:   Row(
              children: [
                const Text('Weekly:',style: TextStyle(fontWeight:FontWeight.bold),),
                Text('₹${calculateWeekly(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}'),
              ],
            ),
         ),
          SizedBox(
            height: 200,
            child: BarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
              sunAmount: value.calculateDailySummary()[sunday]?? 0,
              monAmount: value.calculateDailySummary()[monday]?? 0,
              tueAmount: value.calculateDailySummary()[tuesday]?? 0,
              wedAmount: value.calculateDailySummary()[wednesday]?? 0,
              thuAmount: value.calculateDailySummary()[thursday]?? 0 ,
              friAmount: value.calculateDailySummary()[friday]?? 0,
              satAmount: value.calculateDailySummary()[saturday]?? 0,
              ),
          ),
        ],
      ),
    );
  }
}