// lib/pages/lendings_page.dart
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/lending.dart';
import 'package:intl/intl.dart';

class LendingsPage extends StatefulWidget {
  //const LendingsPage({Key? key}) : super(key: key);

  @override
  _LendingsPageState createState() => _LendingsPageState();
}

class _LendingsPageState extends State<LendingsPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dbHelper = DatabaseHelper();
  DateTime _selectedDate = DateTime.now();
  String dateselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lendings'),
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
              onPressed: _addLending,
              child: Text('Add Lending',
                style: TextStyle(
                  color: Colors.purpleAccent[100],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Lendings',
              style: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Lending>>(
                future: _dbHelper.getLendings(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  final lendings = snapshot.data!;
                  return ListView.builder(
                    itemCount: lendings.length,
                    itemBuilder: (context, index) {
                      final lending = lendings[index];
                      return ListTile(
                        title: Text(lending.name),
                        subtitle: Text('${lending.amount} - '
                            '${lending.isPaid
                            ? 'Cleared on ${lending.clearedDate}'
                            : 'Not Cleared'}'),
                        // trailing: IconButton(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          // Prevent Row from expanding to full width
                          children: <Widget>[
                            Text("${lending.isPaid
                                ? 'Unmark'
                                : 'Mark'}"),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteLending(lending.id!),
                            ),
                          ],
                        ),
                        // trailing: Row(
                        //   children: [
                        //     Text(
                        //       "Selected Date: ${formatter
                        //           .format(_selectedDate)}",
                        //     ),
                        //     SizedBox(width: 1),
                        //     ElevatedButton(
                        //       onPressed: _pickDate,
                        //       child: Text('Select date'),
                        //     ),
                        //   ],
                        // ),
                        onTap: () {
                          // Show dialog based on the current 'isPaid' status
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Center(
                                    child: new Text(lending.isPaid
                                        ? 'Mark as Not Cleared?'
                                        : 'Mark as Cleared?',
                                        textAlign: TextAlign.center)),
                                //content:

                                content:
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(lending.isPaid
                                        ? 'Do you want to unmark this transaction as cleared?\n\n'
                                        'Name: ${lending.name}\n'
                                        'Amount: ${lending.amount}\n'
                                        'Date: ${lending.date}\n'
                                        : 'Do you want to mark this transaction as cleared?\n\n'
                                        'Name: ${lending.name}\n'
                                        'Amount: ${lending.amount}\n'
                                        'Date: ${lending.date}\n'),

                                    SizedBox(height: 10),
                                    Visibility(
                                      visible: !lending.isPaid,
                                      child: Column(
                                        children: [
                                          Text("Selected Date: ${formatter
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
                                    )

                                  ],
                                ),

                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text('Cancel',
                                      style: TextStyle(
                                        color: Colors.purpleAccent[100],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Perform the appropriate action based on the state
                                      _markAsPaid(lending);
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text(
                                      lending.isPaid ? 'Unmark' : 'Mark',
                                      style: TextStyle(
                                        color: Colors.purpleAccent[100],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
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

  void _addLending() async {
    final name = _nameController.text;
    final amount = double.parse(_amountController.text);
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final lending = Lending(name: name,
        amount: amount,
        date: formattedDate,
        clearedDate: formattedDate);
    await _dbHelper.insertLending(lending);
    setState(() {});
    _nameController.clear();
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


  void _markAsPaid(Lending lending) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    lending.isPaid = !lending.isPaid;
    lending.clearedDate = formattedDate;
    await _dbHelper.updateLending(lending);
    setState(() {});
  }

  void _deleteLending(int id) async {
    await _dbHelper.deleteLending(id);
    setState(() {});
  }
}
