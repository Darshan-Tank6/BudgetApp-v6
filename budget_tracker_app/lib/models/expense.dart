// lib/models/expense.dart
class Expense {
  int? id;
  String name;
  double amount;
  String type;
  String date;


  Expense(
      {this.id, required this.name, required this.amount, required this.type, required this.date});

  Expense copyWith({
    int? id,
    String? name,
    double? amount,
    String? type,
    String? date,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'type': type,
      'date': date,
    };
  }
}

