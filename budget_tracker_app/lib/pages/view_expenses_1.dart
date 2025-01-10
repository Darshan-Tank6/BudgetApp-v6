// import 'package:flutter/material.dart';
// import '../helpers/database_helper.dart';
// import '../models/expense.dart';
// import 'package:intl/intl.dart';
//
// DateTime? parseDate(String dateString) {
//   try {
//     return DateTime.parse(dateString);
//   } catch (e) {
//     // Handle parsing errors, e.g., log the error or return a default date
//     print('Error parsing date: $e');
//     return null;
//   }
// }
//
// Widget buildExpansionTile(Map<String, dynamic> group) {
//   return ExpansionTile(
//     title: Text(group['monthYear']),
//     children: group['expenses'].map((expense) {
//       return ListTile(
//         title: Text(expense.name),
//         subtitle: Text(
//             '₹${expense.amount.toStringAsFixed(2)} - ${expense.date.toLocal()
//                 .toString()
//                 .split(' ')[0]}'),
//       );
//     }).toList(),
//   );
// }
//
// List<Map<String, dynamic>> groupExpensesByMonthYear(List<Expense> expenses) {
//   Map<String, List<Expense>> groupedExpenses = {};
//
//   for (Expense expense in expenses) {
//     DateTime? date = parseDate(expense.date);
//     if (date != null) {
//       String key = '${date.year}-${date.month}';
//       groupedExpenses.putIfAbsent(key, () => []);
//       groupedExpenses[key]!.add(expense);
//     }
//   }
//
//   return groupedExpenses.entries.map((entry) {
//     return {
//       'monthYear': entry.key,
//       'expenses': entry.value,
//     };
//   }).toList();
// }
//
//
//
// class ViewExpensePage extends StatefulWidget {
//   //final List<Expense> expenses;
//   @override
//   _ViewExpensePageState createState() => _ViewExpensePageState();
// }
//
// class _ViewExpensePageState extends State<ViewExpensePage> {
//   late List<Map<String, dynamic>> _groupedExpenses;
//   final _dbHelper = DatabaseHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _groupedExpenses = groupExpensesByMonthYear(widget.expenses);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List of Expenses'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//             children: [
//             // Expanded(
//             //   child: FutureBuilder<List<Expense>>(
//             //     future: _dbHelper.getExpenses(),
//             //     builder: (context, snapshot) {
//             //       if (!snapshot.hasData) return CircularProgressIndicator();
//             //       final expenses = snapshot.data!;
//             //       return ListView.builder(
//             //         itemCount: expenses.length,
//             //         itemBuilder: (context, index) {
//             //           final expense = expenses[index];
//             //           return ListTile(
//             //             title: Text(expense.name),
//             //             subtitle: Text('${expense.amount} (${expense
//             //                 .type}) ${expense.date}'),
//             //             trailing: Row(
//             //               mainAxisSize: MainAxisSize.min,
//             //             ),
//             //           );
//             //         },
//             //       );
//             //     },
//             //   ),
//             // ),
//             @override
//             Widget build(BuildContext context) {
//       return ListView.builder(
//       itemCount: _groupedExpenses.length,
//       itemBuilder: (context, index) {
//       final monthYear = _groupedExpenses[index]['monthYear'];
//       final expenses = _groupedExpenses[index]['expenses'];
//
//       return buildExpansionTile(monthYear, expenses);
//       },
//       );
//       }
//         ],
//       ),
//     ),);
//   }
//
//
// }

import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpensesByMonthYear extends StatefulWidget {
  @override
  _ExpensesByMonthYearState createState() => _ExpensesByMonthYearState();
}

class _ExpensesByMonthYearState extends State<ExpensesByMonthYear> {
  late Future<List<String>> _monthsYearsFuture;
  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _monthsYearsFuture =
        _dbHelper
            .getDistinctMonthsYears('expenses'); // Fetch distinct months-years
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses by Month & Year'),
      ),
      body: FutureBuilder<List<String>>(
        future: _monthsYearsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          }

          final monthsYears = snapshot.data!;
          return ListView.builder(
            itemCount: monthsYears.length,
            itemBuilder: (context, index) {
              final monthYear = monthsYears[index];
              return FutureBuilder<List<Expense>>(
                future: _dbHelper.getRecordsByMonthYear(
                  monthYear,
                  'expenses',
                      (map) =>
                      Expense(
                        id: map['id'],
                        name: map['name'],
                        amount: map['amount'],
                        type: map['type'],
                        date: map['date'],
                      ),
                ),
                builder: (context, expenseSnapshot) {
                  if (expenseSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return ExpansionTile(
                      title: Text(monthYear),
                      children: [Center(child: CircularProgressIndicator())],
                    );
                  } else if (expenseSnapshot.hasError) {
                    return ExpansionTile(
                      title: Text(monthYear),
                      children: [Center(
                          child: Text('Error: ${expenseSnapshot.error}'))
                      ],
                    );
                  }

                  final expenses = expenseSnapshot.data!;
                  return ExpansionTile(
                    title: Text(monthYear),
                    children: expenses.isNotEmpty
                        ? expenses.map((expense) {
                      return ListTile(
                        title: Text(expense.name),
                        subtitle: Text('Amount: ${expense.amount}'),
                        trailing: Text(expense.type),
                      );
                    }).toList()
                        : [ListTile(title: Text('No expenses found'))],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
