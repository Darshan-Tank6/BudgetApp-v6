import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpensePage extends StatefulWidget {
  //const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedType; // Store the selected type
  final _dbHelper = DatabaseHelper();
  List<String> _budgetNames2 = []; // List to hold the budget types

  List<Map<String, dynamic>> _budgetNames = []; // Store data here

  List<String> _budgetactualBalance = []; // List to hold the budget types

  //Date
  DateTime _selectedDate = DateTime.now();
  String dateselected = DateFormat('yyyy-MM-dd').format(DateTime.now());

///////////////////////////////////////////////////////////////////////////
  String monthYear = DateFormat('yyyy-MM').format(DateTime.now());

//////////////////////////////////////////////////////////////////////////
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    // _loadBudgetTypes(); // Load budget types when the page is initialized
    fetchBudgetData(); // Fetch data when widget is initialized
  }

  //function to get
  void fetchBudgetData() {
    _dbHelper.getRecordsByMonthYear(
      monthYear,
      'budgets',
          (map) { // this should be a function that handles one record (map)
        setState(() {
          // Convert the record into a map with only name and balance
          _budgetNames.add({
            'name': map['name'],
            'actualBalance': map['actualBalance']
          });
        });
      },
    );
  }


  // Method to load the budget types from the database
  // Future<void> _loadBudgetTypes() async {
  //   final names = await _dbHelper
  //       .getBudgetNames2(); // Retrieve types from the database
  //   setState(() {
  //     _budgetNames2 = names; // Update the list of budget types
  //     if (_budgetNames2.isNotEmpty) {
  //       _selectedType = _budgetNames2[0]; // Select the first type by default
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Expenses'),
        title: new Center(
            child: new Text('Expense', textAlign: TextAlign.center)),
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
            SizedBox(height: 20,),
            SizedBox(
              //width: 300,
              height: 60,
              child: // Dropdown for selecting the type of expense
              DropdownButtonFormField<String>(
                value: _selectedType,
                hint: Text('Select Type'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType =
                        newValue; // Update selected type with just the name
                  });
                },
                items: _budgetNames.map<DropdownMenuItem<String>>((map) {
                  // Create a string with both name and balance
                  String nameWithBalance = '${map['name']} (Balance: ${map['actualBalance']})';

                  return DropdownMenuItem<String>(
                    value: map['name'], // Use only name as the value
                    child: Text(nameWithBalance), // Display name with balance
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Type',
                  border: UnderlineInputBorder(),
                ),
              ),


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
              onPressed: _addExpense,
              child: Text('Add Expense',
                style: TextStyle(
                  color: Colors.purpleAccent[100],
                ),
              ),
            ),
            //SizedBox(height: 20),
            // SizedBox(
            //   child: new Center(
            //       child: new Text("Expenses", textAlign: TextAlign.center,
            //         style: new TextStyle(
            //           fontSize: 20.0,
            //         ),
            //       )
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: _dbHelper.clearAllExpenses,
            //   child: Text('Clear all Expense'),
            // ),


            // Flexible(
            //   child: FutureBuilder<List<Expense>>(
            //     future: _dbHelper.getExpenses(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) return CircularProgressIndicator();
            //       final expenses = snapshot.data!;
            //       return ListView.builder(
            //         itemCount: expenses.length,
            //         itemBuilder: (context, index) {
            //           final expense = expenses[index];
            //           return ListTile(
            //             title: Text(expense.name),
            //             subtitle: Text('${expense.amount} (${expense
            //                 .type}) ${expense.date}'),
            //             trailing: Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 IconButton(
            //                   icon: Icon(Icons.edit),
            //                   onPressed: () => _editExpense(expense),
            //                 ),
            //                 IconButton(
            //                   icon: Icon(Icons.delete),
            //                   onPressed: () =>
            //                       _deleteExpense(expense.id!, expense.amount!),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),

            // Expanded(
            //   child: FutureBuilder<List<Expense>>(
            //     future: _dbHelper.getExpenses(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) return CircularProgressIndicator();
            //       final expenses = snapshot.data!;
            //       return ListView.builder(
            //         itemCount: expenses.length,
            //         itemBuilder: (context, index) {
            //           final expense = expenses[index];
            //           return ListTile(
            //             title: Text(expense.name),
            //             subtitle: Text('${expense.amount} (${expense
            //                 .type}) ${expense.date}'),
            //             trailing: Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 IconButton(
            //                   icon: Icon(Icons.edit),
            //                   onPressed: () => _editExpense(expense),
            //                 ),
            //                 IconButton(
            //                   icon: Icon(Icons.delete),
            //                   onPressed: () =>
            //                       _deleteExpense(expense.id!, expense.amount!),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _addExpense() async {
    if (_selectedType == null) {
      // Show an error message if no type is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a type')),
      );
      return;
    }

    final name = _nameController.text;
    final amount = double.parse(_amountController.text);
    final type = _selectedType!; // Use the selected type for the expense
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    print(formattedDate);
    final expense = Expense(
        name: name, amount: amount, type: type, date: formattedDate);

    await _dbHelper.insertExpense(expense); // Insert expense into the database

    // Update the actualBalance in the budget after recording the expense
    await _dbHelper.updateActualBalance(amount, type);


    setState(() {}); // Refresh the page
    _nameController.clear(); // Clear text fields
    _amountController.clear();
  }

  //edit expenses
  void _editExpense(Expense expense) async {
    final nameController = TextEditingController(text: expense.name);
    final amountController = TextEditingController(
        text: expense.amount.toString());
    String? selectedType;

    final type = expense.type!; // Use the selected type for the expense
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    //final typeController = TextEditingController(text: budget.type);
    await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            //title: Text('Edit Expense'),
            title: new Center(child: new Text(
                'Edit Expense', textAlign: TextAlign.center)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                //SizedBox(height: 20),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                //SizedBox(height: 20),
                // DropdownButton<String>(
                //   value: selectedType,
                //   hint: Text('Select Type'),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedType = newValue; // Update selected type
                //     });
                //   },
                //   items: _budgetNames.map<DropdownMenuItem<String>>((
                //       String name) {
                //     return DropdownMenuItem<String>(
                //       value: name,
                //       child: Text(name),
                //     );
                //   }).toList(),
                // ),

                DropdownButtonFormField<String>(
                  value: _selectedType,
                  hint: Text('Select Type'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedType =
                          newValue; // Update selected type with just the name
                    });
                  },
                  items: _budgetNames.map<DropdownMenuItem<String>>((map) {
                    // Create a string with both name and balance
                    String nameWithBalance = '${map['name']} (Balance: ${map['actualBalance']})';

                    return DropdownMenuItem<String>(
                      value: map['name'], // Use only name as the value
                      child: Text(nameWithBalance), // Display name with balance
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: UnderlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20,),

                Column(
                  children: [
                    Text(
                      "Selected Date: ${formatter
                          .format(_selectedDate)}",
                    ),
                    SizedBox(height: 10),
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
                //SizedBox(height: 20),
                // TextField(
                //   controller: typeController,
                //   decoration: InputDecoration(labelText: 'Type'),
                // ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel',
                  style: TextStyle(
                    color: Colors.purpleAccent[100],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final updatedExpense = expense.copyWith(
                    name: nameController.text,
                    amount: double.parse(amountController.text),
                    type: selectedType,
                    date: formattedDate,
                    //type: typeController.text,
                  );


                  await _dbHelper.revertUpdateonBudget(
                      expense.amount!, expense.type!);
                  //await _dbHelper.deleteExpense(expense.id!);

                  //await _dbHelper.insertExpense(updatedExpense);
                  await _dbHelper.editExpense(updatedExpense);
                  // Update the actualBalance in the budget after recording the expense
                  await _dbHelper.updateActualBalance(
                      updatedExpense.amount, updatedExpense.type);
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: Text('Save',
                  style: TextStyle(
                    color: Colors.purpleAccent[100],
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _deleteExpense(int id, double amount) async {
    final type = _selectedType!; // Use the selected type for the expense
    await _dbHelper.revertUpdateonBudget(amount, type);
    await _dbHelper.deleteExpense(id);
    setState(() {});
  }

  //Selector for date
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
}
