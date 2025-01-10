// lib/pages/expense_page.dart
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/expense.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _typeController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Add Expense'),
            ),
            Expanded(
              child: FutureBuilder<List<Expense>>(
                future: _dbHelper.getExpenses(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  final expenses = snapshot.data!;
                  return ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return ListTile(
                        title: Text(expense.name),
                        subtitle: Text('${expense.amount} (${expense.type})'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addExpense() async {
    final name = _nameController.text;
    final amount = double.parse(_amountController.text);
    final type = _typeController.text;
    final expense = Expense(name: name, amount: amount, type: type);
    await _dbHelper.insertExpense(expense);
    setState(() {});
    _nameController.clear();
    _amountController.clear();
    _typeController.clear();
  }
}
