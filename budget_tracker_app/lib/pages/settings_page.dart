import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  final _dbHelper = DatabaseHelper();

  // Define the function that will be called when the button is pressed
  //final VoidCallback onButtonPressed;

  // SettingsPage({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    // Sample list of text items
    final List<String> items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: Column(
        children: [
          // Expanded ListView to display text items
          Expanded(
            child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: Text('clear All Income '),
                    //onTap: () {
                    //  Navigator.pop(context);
                    //},
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: Text("Clear All incomes"),
                          onPressed: _dbHelper.clearAllIncomes,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Clear All Expenses"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: Text("Clear All expenses"),
                          onPressed: _dbHelper.clearAllExpenses,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Clear All Budgets"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: _dbHelper.clearAllBudgets,
                          child: Text('Clear All Budgets',
                            style: TextStyle(
                              color: Colors.purpleAccent[100],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }

}
