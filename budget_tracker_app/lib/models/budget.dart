// // lib/models/Budget.dart
// class Budget {
//   int? id;
//   String name;
//   double amount;
//   String type;
//   double actualBudget;
//   double actualBalance;
//
//   Budget(
//       {this.id, required this.name, required this.amount, required this.type, required this.actualBudget, required this.actualBalance});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'amount': amount,
//       'type': type,
//       'actualBudget': actualBudget,
//       'actualBalance': actualBalance,
//     };
//   }
// }

class Budget {
  final int? id;
  final String name;
  final double amount;

  //final String type;
  final double actualBudget;
  final double actualBalance;
  final String date;

  Budget({
    this.id,
    required this.name,
    required this.amount,
    //required this.type,
    required this.actualBudget,
    required this.actualBalance,
    required this.date,
  });

  Budget copyWith({
    int? id,
    String? name,
    double? amount,
    //String? type,
    double? actualBudget,
    double? actualBalance,
    String? date,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      //type: type ?? this.type,
      actualBudget: actualBudget ?? this.actualBudget,
      actualBalance: actualBalance ?? this.actualBalance,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      //'type': type,
      'actualBudget': actualBudget,
      'actualBalance': actualBalance,
      'date': date,
    };
  }

  // fromMap method to convert the database record into a Budget object
  static Budget fromMap(Map<String, dynamic> map) {
    print('Mapping map to Budget: $map'); // Debugging line
    return Budget(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      actualBudget: map['actualBudget'],
      actualBalance: map['actualBalance'],
      date: map['date'],
    );
  }
}