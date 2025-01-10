// import 'package:flutter/material.dart';
// import '../helpers/database_helper.dart';
// import '../models/budget.dart';
// import 'package:intl/intl.dart';
//
// class BudgetsByMonthYear extends StatefulWidget {
//   @override
//   _BudgetsByMonthYearState createState() => _BudgetsByMonthYearState();
// }
//
// class _BudgetsByMonthYearState extends State<BudgetsByMonthYear> {
//   late Future<List<String>> _monthsYearsFuture;
//   final _dbHelper = DatabaseHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _monthsYearsFuture =
//         _dbHelper
//             .getDistinctMonthsYears('budgets'); // Fetch distinct months-years
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Budgets by Month & Year'),
//       ),
//       body: FutureBuilder<List<String>>(
//         future: _monthsYearsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available.'));
//           }
//
//           final monthsYears = snapshot.data!;
//           return ListView.builder(
//             itemCount: monthsYears.length,
//             itemBuilder: (context, index) {
//               final monthYear = monthsYears[index];
//               return FutureBuilder<List<Budget>>(
//                 future: _dbHelper.getRecords(
//                   'expenses', monthYear, Budget.fromMap,),
//                 builder: (context, budgetSnapshot) {
//                   if (budgetSnapshot.connectionState ==
//                       ConnectionState.waiting) {
//                     return ExpansionTile(
//                       title: Text(monthYear),
//                       children: [Center(child: CircularProgressIndicator())],
//                     );
//                   } else if (budgetSnapshot.hasError) {
//                     return ExpansionTile(
//                       title: Text(monthYear),
//                       children: [Center(
//                           child: Text('Error: ${budgetSnapshot.error}'))
//                       ],
//                     );
//                   }
//                   if (budgetSnapshot.hasData) {
//                     final budgets = budgetSnapshot.data!;
//                     print('Fetched budgets: $budgets'); // Debugging line
//                   }
//
//                   final budgets = budgetSnapshot.data!;
//                   return ExpansionTile(
//                     title: Text(monthYear),
//                     children: budgets.isNotEmpty
//                         ? budgets.map((budget) {
//                       return ListTile(
//                         title: Text(budget.name),
//                         subtitle: Text('Amount: ${budget.amount}'),
//                         //trailing: Text(budget.type),
//                       );
//                     }).toList()
//                         : [ListTile(title: Text('No budgets found'))],
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> fetchBudgets() async {
//     String monthYear = '2024-12'; // Example monthYear
//
//     final budgets = await _dbHelper.getRecords<Budget>(
//       'expenses',
//       monthYear,
//       Budget.fromMap,
//     );
//
//     print('Fetched budgets: $budgets'); // Log the fetched budgets
//   }
// }

import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/budget.dart'; // Make sure this is imported
import 'package:intl/intl.dart';

class BudgetsByMonthYear extends StatefulWidget {

  @override
  _BudgetsByMonthYearState createState() => _BudgetsByMonthYearState();
}

class _BudgetsByMonthYearState extends State<BudgetsByMonthYear> {
  late Future<List<String>> _monthsYearsFuture;
  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _monthsYearsFuture = _dbHelper.getDistinctMonthsYears('budgets');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budgets by Month & Year'),
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
              return FutureBuilder<List<Budget>>(
                future: _dbHelper.getRecordsByMonthYear(
                  monthYear,
                  'budgets',
                      (map) =>
                      Budget(
                        id: map['id'],
                        name: map['name'],
                        amount: map['amount'],
                        actualBudget: map['actualBudget'],
                        actualBalance: map['actualBalance'],
                        date: map['date'],
                      ),
                ),
                builder: (context, budgetSnapshot) {
                  if (budgetSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return ExpansionTile(
                      title: Text(monthYear),
                      children: [Center(child: CircularProgressIndicator())],
                    );
                  } else if (budgetSnapshot.hasError) {
                    return ExpansionTile(
                      title: Text(monthYear),
                      children: [Center(
                          child: Text('Error: ${budgetSnapshot.error}'))
                      ],
                    );
                  }

                  final budgets = budgetSnapshot.data!;
                  return ExpansionTile(
                    title: Text(monthYear),
                    children: budgets.isNotEmpty
                        ? budgets.map((budget) {
                      return ListTile(
                        title: Text(budget.name),
                        subtitle: Text('Amount: ${budget.amount}'),
                      );
                    }).toList()
                        : [ListTile(title: Text('No budgets found'))],
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
