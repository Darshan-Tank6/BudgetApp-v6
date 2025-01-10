// lib/helpers/database_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/income.dart';
import '../models/expense.dart';
import '../models/lending.dart';
import '../models/credit.dart';
import '../models/budget.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'budget_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE incomes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            source TEXT,
            amount REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            amount REAL,
            type TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE lendings(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            amount REAL,
            isPaid INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE credits(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            amount REAL,
            isCleared INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE budgets(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            amount REAL,
            type TEXT
          )
        ''');
      },
    );
  }

  // CRUD operations for Income
  Future<int> insertIncome(Income income) async {
    final db = await database;
    return await db.insert('incomes', income.toMap());
  }

  Future<List<Income>> getIncomes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('incomes');
    return List.generate(maps.length, (i) {
      return Income(
        id: maps[i]['id'],
        source: maps[i]['source'],
        amount: maps[i]['amount'],
      );
    });
  }

  // CRUD operations for Expense
  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
        type: maps[i]['type'],
      );
    });
  }

  // CRUD operations for Lending
  Future<int> insertLending(Lending lending) async {
    final db = await database;
    return await db.insert('lendings', lending.toMap());
  }

  Future<List<Lending>> getLendings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('lendings');
    return List.generate(maps.length, (i) {
      return Lending(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
        isPaid: maps[i]['isPaid'] == 1,
      );
    });
  }

  Future<int> updateLending(Lending lending) async {
    final db = await database;
    return await db.update(
      'lendings',
      lending.toMap(),
      where: 'id = ?',
      whereArgs: [lending.id],
    );
  }

  // CRUD operations for Credit
  Future<int> insertCredit(Credit credit) async {
    final db = await database;
    return await db.insert('credits', credit.toMap());
  }

  Future<List<Credit>> getCredits() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('credits');
    return List.generate(maps.length, (i) {
      return Credit(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
        isCleared: maps[i]['isCleared'] == 1,
      );
    });
  }


  Future<int> updateCredit(Credit credit) async {
    final db = await database;
    return await db.update(
      'credits',
      credit.toMap(),
      where: 'id = ?',
      whereArgs: [credit.id],
    );
  }


  // CRUD operations for Credit
  Future<int> insertBudget(Budget budget) async {
    final db = await database;
    return await db.insert('budgets', budget.toMap());
  }

  Future<List<Budget>> getBudgets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('budgets');
    return List.generate(maps.length, (i) {
      return Budget(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
        type: maps[i]['type'],
        //isCleared: maps[i]['isCleared'] == 1,
      );
    });
  }

}