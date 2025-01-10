// lib/models/credit.dart
class Credit {
  int? id;
  String name;
  double amount;
  bool isCleared;
  String date;
  String clearedDate;

  Credit(
      {this.id, required this.name, required this.amount, this.isCleared = false, required this.date, required this.clearedDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'isCleared': isCleared ? 1 : 0,
      'date': date,
      'clearedDate': clearedDate,
    };
  }
}
