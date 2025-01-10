// import 'package:flutter/material.dart';
// import 'view_budgets.dart'; // Import your pages
// import 'view_incomes.dart';
// import 'view_expenses.dart';
//
// class ListPage extends StatelessWidget {
//   final List<Map<String, dynamic>> items = [
//     {'title': 'Budgets', 'page': BudgetsByMonthYear()},
//     {'title': 'Incomes', 'page': IncomesByMonthYear()},
//     {'title': 'Expenses', 'page': ListOfRecordsByMonthYear()},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Previous Records'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(items[index]['title']),
//             trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => items[index]['page'],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
