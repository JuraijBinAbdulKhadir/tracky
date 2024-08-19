import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracky/data/expense_data.dart';
import 'package:tracky/models/expense_item.dart';
import 'package:tracky/widgets/expense_summary.dart';
import 'package:tracky/widgets/expense_tile.dart';


class Home extends StatefulWidget {
   const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final nameController =TextEditingController();

  final amountController =TextEditingController();

  @override
  void initState() {
   
    super.initState();
    Provider.of<ExpenseData>(context,listen: false).prepareData();
  }

  

  void addNewExpense(){
    showDialog(
      context: context,
     builder:(context)=> AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Add Expenses'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(hintText: 'Expense name',hintStyle: TextStyle(color: Colors.grey)),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
             decoration: const InputDecoration(hintText: 'Expense amount',hintStyle: TextStyle(color: Colors.grey)),
            ),
        ],
      ),
      actions: [
        MaterialButton(onPressed: save, child: const Text('save'),),
        MaterialButton(onPressed: cancel, child: const Text('cancel'),),
      ],
     ) ,
     );
  }

  void clear(){
      nameController.clear();
      amountController.clear();
    }
  
  void delete(ExpenseItem expense){
   Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }

  void save(){
      if(nameController.text.isNotEmpty&&amountController.text.isNotEmpty){
        ExpenseItem newExpense =ExpenseItem(amount:amountController.text ,dateTime:DateTime.now() ,name: nameController.text);
        Provider.of<ExpenseData>(context,listen: false).addNewExpense(newExpense);
      }
      Navigator.pop(context);
      clear();
    }

  void cancel(){
      Navigator.pop(context);
      clear();
    }
  

  

  @override
  Widget build(BuildContext context) {
    
    
      return Consumer<ExpenseData>(
      builder: (context, value, child) =>  Scaffold(
        backgroundColor: Colors.grey.shade300,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed:addNewExpense,
          child:const Icon(Icons.add,color: Colors.white,),
           ),
        body:Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              //------------------
              ExpenseSummary(startOfWeek: value.startOfWeek()!),
              //-----------------
              const SizedBox(height: 20,),
            ListView.builder(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
            itemCount: value.getExpense().length,
            itemBuilder: (context, index) =>
               ExpenseTile(
                 amount: value.getExpense()[index].amount,
                 dateTime: value.getExpense()[index].dateTime,
                 name: value.getExpense()[index].name,
                 deleteTapped: (p0) => delete(value.getExpense()[index]),),
              )
            ],
          ),
        ) ,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }
}