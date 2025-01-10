// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../helpers/database_helper.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  void _fetchExpenses() async {
    final expenses = await _dbHelper.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, double> expenseData = {};
    _expenses.forEach((expense) {
      if (expenseData.containsKey(expense.type)) {
        expenseData[expense.type] = expenseData[expense.type]! + expense.amount;
      } else {
        expenseData[expense.type] = expense.amount;
      }
    });

    final List<PieChartSectionData> sections = expenseData.entries.map((entry) {
      return PieChartSectionData(
        title: entry.key,
        value: entry.value,
        color: Colors.primaries[expenseData.keys.toList().indexOf(entry.key) %
            Colors.primaries.length],
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Center(
        child: PieChart(
          PieChartData(
            sections: sections,
          ),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text(
      //           'Menu',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text('Home'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.monetization_on),
      //         title: Text('Income'),
      //         onTap: () {
      //           Navigator.pushNamed(context, '/income');
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.money_off),
      //         title: Text('Expenses'),
      //         onTap: () {
      //           Navigator.pushNamed(context, '/expense');
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.trending_up),
      //         title: Text('Lendings'),
      //         onTap: () {
      //           Navigator.pushNamed(context, '/lendings');
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.credit_card),
      //         title: Text('Credits'),
      //         onTap: () {
      //           Navigator.pushNamed(context, '/credits');
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.credit_card),
      //         title: Text('Budget'),
      //         onTap: () {
      //           Navigator.pushNamed(context, '/budget');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
