// lib/pages/credits_page.dart
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/credit.dart';
import 'package:intl/intl.dart';

class CreditsPage extends StatefulWidget {
  //const CreditsPage({Key? key}) : super(key: key);

  @override
  _CreditsPageState createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
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
        title: Text('Borrows'),
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
              onPressed: _addCredit,
              child: Text('Add to Borrow',
                style: TextStyle(
                  color: Colors.purpleAccent[100],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Borrows',
              style: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Credit>>(
                future: _dbHelper.getCredits(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  final credits = snapshot.data!;
                  return ListView.builder(
                    itemCount: credits.length,
                    itemBuilder: (context, index) {
                      final credit = credits[index];
                      return ListTile(
                        title: Text(credit.name),
                        subtitle: Text('${credit.amount} - '
                            '${credit.isCleared ? 'Cleared on ${credit
                            .clearedDate}' : 'Not Cleared'}'),
                        // trailing: ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          // Prevent Row from expanding to full width
                          children: <Widget>[
                            Text("${credit.isCleared
                                ? 'Unmark'
                                : 'Mark'}"),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteCredit(credit.id!),
                            ),
                          ],
                        ),
                        //text: Text('Cleared:'),
                        // trailing: Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     IconButton(
                        //       icon: Icon(
                        //         credit.isCleared ? Icons.check_box : Icons
                        //             .check_box_outline_blank,
                        //       ),
                        //       //onPressed: () => _markAsCleared(credit),
                        //       onPressed: () {
                        //         if (credit.isCleared) {
                        //           // Show confirmation dialog when the item is already cleared
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return AlertDialog(
                        //                 title: Text('Are you sure?'),
                        //                 content: Text(
                        //                     'Do you really want to change the status?'),
                        //                 actions: <Widget>[
                        //                   TextButton(
                        //                     onPressed: () {
                        //                       Navigator.of(context)
                        //                           .pop(); // Close the dialog
                        //                     },
                        //                     child: Text('Cancel'),
                        //                   ),
                        //                   TextButton(
                        //                     onPressed: () {
                        //                       _markAsCleared(
                        //                           credit); // Perform the action if confirmed
                        //                       Navigator.of(context)
                        //                           .pop(); // Close the dialog
                        //                     },
                        //                     child: Text('Yes'),
                        //                   ),
                        //                 ],
                        //               );
                        //             },
                        //           );
                        //         } else {
                        //           // If it's not cleared, simply mark it as cleared
                        //           _markAsCleared(credit);
                        //         }
                        //       },
                        //     ),
                        //     IconButton(
                        //       icon: Icon(Icons.access_time_rounded),
                        //       onPressed: () => _pickDate(),
                        //     ),
                        //   ],
                        // ),
                        onTap: () {
                          // Show dialog based on the current 'isCleared' status
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Center(
                                    child: new Text(credit.isCleared
                                        ? 'Mark as Not Cleared?'
                                        : 'Mark as Cleared?',
                                        textAlign: TextAlign.center)),
                                //title: Text(),
                                content:
                                // Text(credit.isCleared
                                //     ? 'Do you want to mark this transaction as not cleared?\n\n'
                                //     'Name: ${credit.name}\n'
                                //     'Amount: ${credit.amount}\n'
                                //     'Borrowed on: ${credit.date}\n'
                                //     : 'Do you want to mark this transaction as cleared?\n\n'
                                //     'Name: ${credit.name}\n'
                                //     'Amount: ${credit.amount}\n'
                                //     'Borrowed on: ${credit.date}\n'
                                // ),
                                //SizedBox(height: 20,),

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(credit.isCleared
                                        ? 'Do you want to mark this transaction as not cleared?\n\n'
                                        'Name: ${credit.name}\n'
                                        'Amount: ${credit.amount}\n'
                                        'Borrowed on: ${credit.date}\n'
                                        : 'Do you want to mark this transaction as cleared?\n\n'
                                        'Name: ${credit.name}\n'
                                        'Amount: ${credit.amount}\n'
                                        'Borrowed on: ${credit.date}\n'
                                    ),

                                    SizedBox(height: 10),
                                    Visibility(
                                      visible: !credit.isCleared,
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
                                      _markAsCleared(credit);
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text(
                                      credit.isCleared ? 'Unmark' : 'Mark',
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

  void _addCredit() async {
    final name = _nameController.text;
    final amount = double.parse(_amountController.text);
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final credit = Credit(name: name,
        amount: amount,
        date: formattedDate,
        clearedDate: formattedDate);
    await _dbHelper.insertCredit(credit);
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

  void _markAsCleared(Credit credit) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    credit.clearedDate = formattedDate;
    credit.isCleared = !credit.isCleared;
    await _dbHelper.updateCredit(credit);
    setState(() {});
  }

  void _deleteCredit(int id) async {
    await _dbHelper.deleteCredit(id);
    setState(() {});
  }
}
