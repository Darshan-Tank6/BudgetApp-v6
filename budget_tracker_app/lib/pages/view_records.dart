import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/database_helper.dart';
import '../models/expense.dart';
import '../models/budget.dart';
import '../models/income.dart';

class ListOfRecordsByMonthYear extends StatefulWidget {
  const ListOfRecordsByMonthYear({Key? key}) : super(key: key);

  @override
  _ListOfRecordsByMonthYearState createState() =>
      _ListOfRecordsByMonthYearState();
}

class _ListOfRecordsByMonthYearState extends State<ListOfRecordsByMonthYear> {
  late Future<List<String>> _monthsYearsFuture;
  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _monthsYearsFuture = _dbHelper.getDistinctMonthsYears(
        'incomes'); // Fetch distinct months-years
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
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
              final formattedMonthYear = DateFormat("MMMM yyyy").format(
                  DateTime.parse("${monthYear}-01"));
              return ListTile(
                title: Text(formattedMonthYear),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecordsTabsScreen(
                            monthYear: monthYear,
                            dbHelper: _dbHelper,
                          ),
                    ),
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

class RecordsTabsScreen extends StatefulWidget {
  final String monthYear;
  final DatabaseHelper dbHelper;

  const RecordsTabsScreen({
    required this.monthYear,
    required this.dbHelper,
  });

  @override
  _RecordsTabsScreenState createState() => _RecordsTabsScreenState();
}

class _RecordsTabsScreenState extends State<RecordsTabsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> _fetchRecords(String type) {
    final recordFetchers = {
      'Income': () =>
          widget.dbHelper.getRecordsByMonthYear(
            widget.monthYear,
            'incomes',
                (map) =>
                Income(
                  id: map['id'],
                  source: map['source'],
                  amount: map['amount'],
                  date: map['date'],
                ),
          ),
      'Budget': () =>
          widget.dbHelper.getRecordsByMonthYear(
            widget.monthYear,
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
      'Expense': () =>
          widget.dbHelper.getRecordsByMonthYear(
            widget.monthYear,
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
    };

    return recordFetchers[type]!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records for ${widget.monthYear}'),
        bottom: TabBar(
          //labelColor: Colors.blue, // Color for the selected tab text
          labelColor: Colors.purpleAccent[100], // Color for unselected tab text
          indicatorColor: Colors.purpleAccent[100],
          controller: _tabController,
          tabs: [
            Tab(text: 'Income'),
            Tab(text: 'Expense'),
            Tab(text: 'Budget'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecordList('Income'),
          _buildRecordList('Expense'),
          _buildRecordList('Budget'),
        ],
      ),
    );
  }

  Widget _buildRecordList(String type) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchRecords(type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No $type records found.'));
        }

        final records = snapshot.data!;
        return ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            if (record is Expense) {
              return ListTile(
                title: Text(record.name),
                subtitle: Text('Amount: ${record.amount}'),
                trailing: Text(record.type),
              );
            } else if (record is Income) {
              return ListTile(
                title: Text(record.source),
                subtitle: Text('Amount: ${record.amount}'),
                trailing: Text(record.date),
              );
            } else if (record is Budget) {
              return ListTile(
                title: Text(record.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Budget: ${record.actualBudget}'),
                    Text('Balance: ${record.actualBalance}'),
                  ],
                ),
                trailing: Text('Amount: ${record.amount}'),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
