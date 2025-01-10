// lib/pages/income_page.dart
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/income.dart';
import 'package:intl/intl.dart';

class IncomePage extends StatefulWidget {
  //const IncomePage({Key? key}) : super(key: key);

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final _sourceController = TextEditingController();
  final _amountController = TextEditingController();
  final _dbHelper = DatabaseHelper();
  DateTime _selectedDate = DateTime.now();
  String dateselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String yearMonth = DateFormat('yyyy-MM').format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Income'),
        title: new Center(
            child: new Text('Income', textAlign: TextAlign.center)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sourceController,
              decoration: InputDecoration(labelText: 'Source'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20,),

            Row(
              children: [
                Text(
                  "Selected Date: ${formatter
                      .format(_selectedDate)}",
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text('Select date',
                    style: TextStyle(
                      color: Colors.purpleAccent[100],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addIncome,
              child: Text('Add Income',
                style: TextStyle(
                  color: Colors.purpleAccent[100],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              child: new Center(
                  child: new Text("Income", textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  )
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Income>>(
                future: _dbHelper.getIncomesByMonthYearIncomes(yearMonth),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  final incomes = snapshot.data!;
                  return ListView.builder(
                    itemCount: incomes.length,
                    itemBuilder: (context, index) {
                      final income = incomes[index];
                      return ListTile(
                        title: Text(income.source),
                        subtitle: Text(income.amount.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteIncome(income.id!),
                            ),
                          ],
                        ),
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

  void _addIncome() async {
    final source = _sourceController.text;
    final amount = double.parse(_amountController.text);
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final income = Income(source: source, amount: amount, date: formattedDate);
    await _dbHelper.insertIncome(income);
    setState(() {});
    _sourceController.clear();
    _amountController.clear();
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
    print(_selectedDate);
  }


  void _deleteIncome(int id) async {
    await _dbHelper.deleteIncome(id);
    setState(() {});
  }
}
