// lib/models/lending.dart
class Lending {
  int? id;
  String name;
  double amount;
  bool isPaid;
  String date;
  String clearedDate;

  Lending(
      {this.id, required this.name, required this.amount, this.isPaid = false, required this.date, required this.clearedDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'isPaid': isPaid ? 1 : 0,
      'date': date,
      'clearedDate': clearedDate,
    };
  }
}

