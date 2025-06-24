import 'package:expence_tracker/components/expense_summary.dart';
import 'package:expence_tracker/components/expense_tile.dart';
import 'package:expence_tracker/data/expense_data.dart';
import 'package:expence_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();


  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                hintText: 'Enter expense name',
              ),
            ),

            // expense amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
              ),
            ),
          ],

        ), // Column
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ), // MaterialButton
         
          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ), // MaterialButton
        ],
      ), // AlertDialog
    );
  }

  // save
  void save() {
    // create expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    ); // ExpenseItem
    // add the new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
   
    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          foregroundColor: Colors.grey[300],
          child: const Icon(Icons.add),
        ), // FloatingActionButton
        body: ListView(children: [
          // weekly summary
          ExpenseSummary(startOfWeek: value.startOfWeekDate()),


          const SizedBox(height: 20), // spacing



          // expense list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index) => ExpenseTile(
              name: value.getAllExpenseList()[index].name,
              amount: value.getAllExpenseList()[index].amount,
              dateTime: value.getAllExpenseList()[index].dateTime,
            ), // ExpenseTile
          ), // ListView.builder
        ]), // ListView
      ), // Scaffold
    ); // Consumer
  }
}