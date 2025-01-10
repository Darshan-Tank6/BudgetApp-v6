// lib/pages/budgets_page.dart
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/budget.dart';
import 'package:intl/intl.dart';

class BudgetsPage extends StatefulWidget {
  //const BudgetsPage({Key? key}) : super(key: key);

  @override
  _BudgetsPageState createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _typeController = TextEditingController();
  final _dbHelper = DatabaseHelper();
  DateTime _selectedDate = DateTime.now();
  String dateselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Budget'),
        title: new Center(
            child: new Text('Budget', textAlign: TextAlign.center)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<double>(
              future: calculateRemainingIncome(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error calculating remaining income: ${snapshot
                        .error}');
                  } else {
                    final remainingIncome = snapshot.data!;
                    return Text(
                      'Remaining Income To Budget: ₹${remainingIncome
                          .toStringAsFixed(
                          2)}',
                      style: TextStyle(
                        color: remainingIncome >= 0 ? Colors.green : Colors.red,
                      ),
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            // FutureBuilder<double>(
            //   future: _dbHelper.calculateTotalIncome(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.hasError) {
            //         return Text(
            //             'Error calculating total income: ${snapshot.error}');
            //       } else {
            //         final totalIncome = snapshot.data!;
            //         return Text(
            //             'Total Income: ₹${totalIncome.toStringAsFixed(2)}');
            //       }
            //     } else {
            //       return CircularProgressIndicator();
            //     }
            //   },
            // ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            // TextField(
            //   controller: _typeController,
            //   decoration: InputDecoration(labelText: 'Type'),
            // ),
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
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _addBudget,
              child: Text('Add to Budget',
                style: TextStyle(
                  color: Colors.purpleAccent[100],
                ),
              ),
            ),
            SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: _dbHelper.clearAllBudgets,
            //   child: Text('Clear All Budgets',
            //     style: TextStyle(
            //       color: Colors.purpleAccent[100],
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            FutureBuilder<double>(
              future: _dbHelper.calculateTotalBudget(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(
                        'Error calculating total budget: ${snapshot.error}');
                  } else {
                    final totalBudget = snapshot.data!;
                    return Text(
                        'Total Budget: ₹${totalBudget.toStringAsFixed(2)}');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              child: new Center(
                  child: new Text("Budgets", textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  )
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Budget>>(
                future: _dbHelper.getBudgets(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  final budgets = snapshot.data!;
                  return ListView.builder(
                    itemCount: budgets.length,
                    itemBuilder: (context, index) {
                      final budget = budgets[index];
                      return ListTile(
                        title: Text(budget.name),
                        subtitle: Text(
                            'Budget: ${budget.actualBudget}\n'
                                'Balance: ${budget.actualBalance}\n'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editBudget(budget),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteBudget(budget.id!),
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

  // void _addBudget() async {
  //   final name = _nameController.text;
  //   final amount = double.parse(_amountController.text);
  //   final type = _typeController.text;
  //   final budget = Budget(
  //     name: name,
  //     amount: amount,
  //     type: type,
  //     actualBalance: amount,
  //     actualBudget: amount,);
  //   await _dbHelper.insertBudgets(budget);
  //   setState(() {});
  //   _nameController.clear();
  //   _amountController.clear();
  //   _typeController.clear();
  // }

  void _addBudget() async {
    final name = _nameController.text;
    final amountText = _amountController.text;

    // Validate the amount input
    double? amount;
    try {
      amount = double.parse(amountText);
    } catch (e) {
      // Handle the error, e.g., show an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Amount'),
            content: Text('Please enter a valid numeric amount.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the function if the amount is invalid
    }

    final type = _typeController.text;
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    print(formattedDate);
    final budget = Budget(
        name: name,
        amount: amount,
        //type: type,
        actualBalance: amount,
        actualBudget: amount,
        date: formattedDate
    );
    await _dbHelper.insertBudget(budget);
    setState(() {});
    _nameController.clear();
    _amountController.clear();
    //_typeController.clear();
  }

  void _editBudget(Budget budget) async {
    final nameController = TextEditingController(text: budget.name);
    final amountController = TextEditingController(
        text: budget.amount.toString());
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    //final typeController = TextEditingController(text: budget.type);
    await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            //title: Text('Edit Budget'),
            title: new Center(child: new Text(
                'Edit Budget', textAlign: TextAlign.center)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
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
                SizedBox(height: 20),
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
                  final updatedBudget = budget.copyWith(
                    name: nameController.text,
                    amount: double.parse(amountController.text),
                    date: formattedDate,
                    //type: typeController.text,
                  );
                  await _dbHelper.editBudget(updatedBudget);
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


  void _deleteBudget(int id) async {
    await _dbHelper.deleteBudget(id);
    setState(() {});
  }

  Future<double> calculateRemainingIncome() async {
    final totalIncome = await _dbHelper.calculateTotalIncome();
    final totalBudget = await _dbHelper.calculateTotalBudget();
    final totalExpense = await _dbHelper.calculateTotalExpense();
    return totalIncome - totalBudget;
  }

}
//
// import 'package:flutter/material.dart';
// import '../helpers/database_helper.dart';
// import '../models/budget.dart';
// import 'package:intl/intl.dart';
//
// class BudgetsPage extends StatefulWidget {
//   @override
//   _BudgetsPageState createState() => _BudgetsPageState();
// }
//
// class _BudgetsPageState extends State<BudgetsPage> {
//   final _nameController = TextEditingController();
//   final _amountController = TextEditingController();
//   final _typeController = TextEditingController();
//   final _dbHelper = DatabaseHelper();
//   DateTime _selectedDate = DateTime.now();
//   String dateselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   DateFormat formatter = DateFormat('yyyy-MM-dd');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('Budget', textAlign: TextAlign.center),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FutureBuilder<double>(
//                 future: calculateRemainingIncome(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError) {
//                       return Text(
//                           'Error calculating remaining income: ${snapshot
//                               .error}');
//                     } else {
//                       final remainingIncome = snapshot.data!;
//                       return Text(
//                         'Remaining Income To Budget: ₹${remainingIncome
//                             .toStringAsFixed(2)}',
//                         style: TextStyle(
//                           color: remainingIncome >= 0 ? Colors.green : Colors
//                               .red,
//                         ),
//                       );
//                     }
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: _amountController,
//                 decoration: InputDecoration(labelText: 'Amount'),
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text("Selected Date: ${formatter.format(_selectedDate)}"),
//                   SizedBox(width: 30),
//                   ElevatedButton(
//                     onPressed: _pickDate,
//                     child: Text(
//                       'Select date',
//                       style: TextStyle(
//                         color: Colors.purpleAccent[100],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _addBudget,
//                 child: Text(
//                   'Add to Budget',
//                   style: TextStyle(
//                     color: Colors.purpleAccent[100],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               FutureBuilder<double>(
//                 future: _dbHelper.calculateTotalBudget(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError) {
//                       return Text(
//                           'Error calculating total budget: ${snapshot.error}');
//                     } else {
//                       final totalBudget = snapshot.data!;
//                       return Text(
//                           'Total Budget: ₹${totalBudget.toStringAsFixed(2)}');
//                     }
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: Text(
//                   "Budgets",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                   ),
//                 ),
//               ),
//               FutureBuilder<List<Budget>>(
//                 future: _dbHelper.getBudgets(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return CircularProgressIndicator();
//                   final budgets = snapshot.data!;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     // Important to make the ListView fit within the scrollable layout
//                     physics: NeverScrollableScrollPhysics(),
//                     // Prevent ListView from scrolling independently
//                     itemCount: budgets.length,
//                     itemBuilder: (context, index) {
//                       final budget = budgets[index];
//                       return ListTile(
//                         title: Text(budget.name),
//                         subtitle: Text(
//                           'Budget: ${budget.actualBudget}\n'
//                               'Balance: ${budget.actualBalance}\n',
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () => _editBudget(budget),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () => _deleteBudget(budget.id!),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _addBudget() async {
//     final name = _nameController.text;
//     final amountText = _amountController.text;
//     double? amount;
//     try {
//       amount = double.parse(amountText);
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Invalid Amount'),
//             content: Text('Please enter a valid numeric amount.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
//     final budget = Budget(
//       name: name,
//       amount: amount,
//       actualBalance: amount,
//       actualBudget: amount,
//       date: formattedDate,
//     );
//     await _dbHelper.insertBudget(budget);
//     setState(() {});
//     _nameController.clear();
//     _amountController.clear();
//   }
//
//   void _editBudget(Budget budget) async {
//     final nameController = TextEditingController(text: budget.name);
//     final amountController = TextEditingController(
//         text: budget.amount.toString());
//     String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
//     await showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Center(child: Text(
//                 'Edit Budget', textAlign: TextAlign.center)),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   controller: amountController,
//                   decoration: InputDecoration(labelText: 'Amount'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 20),
//                 Column(
//                   children: [
//                     Text("Selected Date: ${formatter.format(_selectedDate)}"),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: _pickDate,
//                       child: Text(
//                         'Select date',
//                         style: TextStyle(
//                           color: Colors.purpleAccent[100],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.purpleAccent[100],
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   final updatedBudget = budget.copyWith(
//                     name: nameController.text,
//                     amount: double.parse(amountController.text),
//                     date: formattedDate,
//                   );
//                   await _dbHelper.editBudget(updatedBudget);
//                   Navigator.of(context).pop();
//                   setState(() {});
//                 },
//                 child: Text(
//                   'Save',
//                   style: TextStyle(
//                     color: Colors.purpleAccent[100],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }
//
//   void _pickDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   void _deleteBudget(int id) async {
//     await _dbHelper.deleteBudget(id);
//     setState(() {});
//   }
//
//   Future<double> calculateRemainingIncome() async {
//     final totalIncome = await _dbHelper.calculateTotalIncome();
//     final totalBudget = await _dbHelper.calculateTotalBudget();
//     return totalIncome - totalBudget;
//   }
// }
