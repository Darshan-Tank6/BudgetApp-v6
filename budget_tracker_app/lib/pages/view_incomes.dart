import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/income.dart';
import 'package:intl/intl.dart';

class IncomesByMonthYear extends StatefulWidget {
  @override
  _IncomesByMonthYearState createState() => _IncomesByMonthYearState();
}

class _IncomesByMonthYearState extends State<IncomesByMonthYear> {
  late Future<List<String>> _monthsYearsFuture;
  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _monthsYearsFuture =
        _dbHelper
            .getDistinctMonthsYears('incomes'); // Fetch distinct months-years
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incomes by Month & Year'),
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
              return FutureBuilder<List<Income>>(
                future: _dbHelper.getRecordsByMonthYear(
                  monthYear,
                  'incomes',
                      (map) =>
                      Income(
                        id: map['id'],
                        source: map['source'],
                        amount: map['amount'],
                        date: map['date'],
                      ),
                ),
                builder: (context, incomeSnapshot) {
                  if (incomeSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return ExpansionTile(
                      title: Text(monthYear),
                      children: [Center(child: CircularProgressIndicator())],
                    );
                  } else if (incomeSnapshot.hasError) {
                    return ExpansionTile(
                      title: Text(monthYear),
                      children: [Center(
                          child: Text('Error: ${incomeSnapshot.error}'))
                      ],
                    );
                  }

                  final incomes = incomeSnapshot.data!;
                  return ExpansionTile(
                    title: Text(monthYear),
                    children: incomes.isNotEmpty
                        ? incomes.map((income) {
                      return ListTile(
                        title: Text(income.source),
                        subtitle: Text('Amount: ${income.amount}'),
                        //trailing: Text(income.type),
                      );
                    }).toList()
                        : [ListTile(title: Text('No incomes found'))],
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