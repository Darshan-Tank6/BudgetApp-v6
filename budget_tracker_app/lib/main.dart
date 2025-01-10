// //good bottom nav bar
// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/settings_page.dart';
//
// //import 'pages/view_expenses_1.dart';
// //import 'pages/view_incomes.dart';
// //import 'pages/view_budgets.dart';
// import 'pages/view_list.dart';
// import 'pages/view_records.dart';
//
// void main() {
//   runApp(BudgetTrackerApp());
// }
//
// class BudgetTrackerApp extends StatefulWidget {
//   @override
//   _BudgetTrackerAppState createState() => _BudgetTrackerAppState();
// }
//
// class _BudgetTrackerAppState extends State<BudgetTrackerApp> {
//   int _selectedIndex = 0; // To track the selected bottom navigation bar item
//
//   final List<Widget> _pages = [
//     HomePage(),
//     IncomePage(),
//     ExpensePage(),
//     LendingsPage(),
//     CreditsPage(),
//     BudgetsPage(),
//     //SettingsPage(),
//     //ExpensesByMonthYear(),
//     //IncomesByMonthYear(),
//     //BudgetsByMonthYear(),
//     //ListPage(),
//     ListOfRecordsByMonthYear(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Budget Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: _pages[_selectedIndex], // Display the selected page
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//
//
//             BottomNavigationBarItem(
//               icon: Icon(Icons.attach_money),
//               label: 'Income',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.money_off),
//               label: 'Expense',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//               activeIcon: Icon(Icons.home, color: Colors.blue),
//               //backgroundColor: Colors.blue[100],
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.swap_horiz),
//               label: 'Lendings',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_balance),
//               label: 'Credits',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list),
//               label: 'Budgets',
//             ),
//             // BottomNavigationBarItem(
//             //   icon: Icon(Icons.settings),
//             //   //icon: Icon(Icons.add_home_work_outlined),
//             //   label: 'Settings',
//             // ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle_outlined),
//               //icon: Icon(Icons.add_home_work_outlined),
//               label: 'View Expenses',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle: TextStyle(color: Colors.amber[800]),
//           unselectedLabelStyle: TextStyle(color: Colors.red),
//           elevation: 0.0,
//           //backgroundColor: Colors.blueGrey[800],
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: false,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// //
// // import 'pages/home_page.dart';
// // import 'pages/income_page.dart';
// // import 'pages/expense_page.dart';
// // import 'pages/lendings_page.dart';
// // import 'pages/credits_page.dart';
// // import 'pages/budgets_page.dart';
// // import 'pages/settings_page.dart';
// // import 'pages/view_list.dart';
// // import 'pages/view_records.dart';
// //
// // void main() {
// //   runApp(BudgetTrackerApp());
// // }
// //
// // class BudgetTrackerApp extends StatefulWidget {
// //   @override
// //   _BudgetTrackerAppState createState() => _BudgetTrackerAppState();
// // }
// //
// // class _BudgetTrackerAppState extends State<BudgetTrackerApp> {
// //   int _selectedIndex = 0;
// //
// //   final List<Widget> _pages = [
// //     HomePage(),
// //     IncomePage(),
// //     ExpensePage(),
// //     LendingsPage(),
// //     CreditsPage(),
// //     BudgetsPage(),
// //     ListOfRecordsByMonthYear(),
// //   ];
// //
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Budget Tracker',
// //       theme: ThemeData(
// //         useMaterial3: true, // Enabling Material 3
// //         primarySwatch: Colors.blue,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Budget Tracker"),
// //           backgroundColor: Colors.blue[800],
// //           elevation: 0.0,
// //         ),
// //         body: _pages[_selectedIndex], // Display the selected page
// //         bottomNavigationBar: CurvedNavigationBar(
// //           index: _selectedIndex,
// //           height: 60.0,
// //           items: const <Widget>[
// //             Icon(Icons.attach_money, size: 30),
// //             Icon(Icons.money_off, size: 30),
// //             Icon(Icons.home, size: 30),
// //             Icon(Icons.swap_horiz, size: 30),
// //             Icon(Icons.account_balance, size: 30),
// //             Icon(Icons.list, size: 30),
// //             Icon(Icons.account_circle_outlined, size: 30),
// //           ],
// //           color: Colors.blue[600]!,
// //           buttonBackgroundColor: Colors.blue[700]!,
// //           backgroundColor: Colors.white,
// //           animationCurve: Curves.easeInOut,
// //           animationDuration: const Duration(milliseconds: 300),
// //           onTap: _onItemTapped,
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
//
// // import 'package:flutter/material.dart';
// // import 'pages/home_page.dart';
// // import 'pages/income_page.dart';
// // import 'pages/expense_page.dart';
// // import 'pages/lendings_page.dart';
// // import 'pages/credits_page.dart';
// // import 'pages/budgets_page.dart';
// // import 'pages/view_list.dart';
// // import 'pages/view_records.dart';
// //
// // void main() {
// //   runApp(BudgetTrackerApp());
// // }
// //
// // class BudgetTrackerApp extends StatefulWidget {
// //   @override
// //   _BudgetTrackerAppState createState() => _BudgetTrackerAppState();
// // }
// //
// // class _BudgetTrackerAppState extends State<BudgetTrackerApp> {
// //   int _selectedIndex = 0;
// //
// //   // Primary pages: Home, Income, Expense
// //   final List<Widget> _primaryPages = [
// //     HomePage(),
// //     IncomePage(),
// //     ExpensePage(),
// //   ];
// //
// //   // Secondary pages: Lendings, Credits, Budgets, Records
// //   final List<Widget> _secondaryPages = [
// //     LendingsPage(),
// //     CreditsPage(),
// //     BudgetsPage(),
// //     ListOfRecordsByMonthYear(),
// //   ];
// //
// //   // Switch between primary and secondary pages
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       if (index < 3) {
// //         _selectedIndex = index;
// //       } else {
// //         _selectedIndex = index + 3;
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Budget Tracker',
// //       theme: ThemeData(
// //         useMaterial3: true,
// //         primarySwatch: Colors.blue,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Budget Tracker"),
// //           backgroundColor: Colors.blue[800],
// //           elevation: 0.0,
// //         ),
// //         body: _selectedIndex < 3
// //             ? _primaryPages[_selectedIndex] // Primary pages (Home, Income, Expense)
// //             : _secondaryPages[_selectedIndex - 3], // Secondary pages
// //         bottomNavigationBar: BottomNavigationBar(
// //           currentIndex: _selectedIndex < 3 ? _selectedIndex : 0,
// //           onTap: _onItemTapped,
// //           type: BottomNavigationBarType.fixed,
// //           items: const <BottomNavigationBarItem>[
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.home),
// //               label: 'Home',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.attach_money),
// //               label: 'Income',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.money_off),
// //               label: 'Expense',
// //             ),
// //           ],
// //           selectedItemColor: Colors.blue[600],
// //           unselectedItemColor: Colors.blueGrey,
// //           backgroundColor: Colors.white,
// //         ),
// //         floatingActionButton: _buildExpandableFab(),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildExpandableFab() {
// //     // Basic floating action button that expands when pressed
// //     return FloatingActionButton(
// //       onPressed: () {
// //         // Open a bottom sheet or modal to choose from secondary pages
// //         showModalBottomSheet(
// //           context: context,
// //           builder: (BuildContext context) {
// //             return Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: <Widget>[
// //                 ListTile(
// //                   leading: Icon(Icons.swap_horiz),
// //                   title: Text('Lendings'),
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                     setState(() {
// //                       _selectedIndex = 3;
// //                     });
// //                   },
// //                 ),
// //                 ListTile(
// //                   leading: Icon(Icons.account_balance),
// //                   title: Text('Credits'),
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                     setState(() {
// //                       _selectedIndex = 4;
// //                     });
// //                   },
// //                 ),
// //                 ListTile(
// //                   leading: Icon(Icons.list),
// //                   title: Text('Budgets'),
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                     setState(() {
// //                       _selectedIndex = 5;
// //                     });
// //                   },
// //                 ),
// //                 ListTile(
// //                   leading: Icon(Icons.account_circle_outlined),
// //                   title: Text('Records'),
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                     setState(() {
// //                       _selectedIndex = 6;
// //                     });
// //                   },
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       },
// //       child: Icon(Icons.add),
// //       tooltip: 'Open Secondary Pages',
// //       backgroundColor: Colors.blue[600],
// //     );
// //   }
// // }

//Better version
//////////////////////////////////////////////////////////////////////
//
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'pages/home_page.dart';
import 'pages/income_page.dart';
import 'pages/expense_page.dart';
import 'pages/lendings_page.dart';
import 'pages/credits_page.dart';
import 'pages/budgets_page.dart';
import 'pages/view_records.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        //secondaryColor: Colors.grey[100],
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.deepPurple,
        brightness: Brightness.dark,
        // Customize more properties for dark mode
      ),
      themeMode: ThemeMode.system,
      // Automatically switches based on system settings
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Tracks the selected tab

  // List of primary pages for the BottomNavigationBar
  final List<Widget> _pages = [
    HomePage(),
    IncomePage(),
    ExpensePage(),
    BudgetsPage(),
  ];

  // Function to handle BottomNavigationBar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Finance Tracker'),
      // ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.purpleAccent[100],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
              //  color: Colors.purpleAccent,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money,
              //color: Colors.purpleAccent,
            ),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off,
              //  color: Colors.purpleAccent,
            ),
            label: 'Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance,
              //  color: Colors.purpleAccent,
            ),
            label: 'Budget',
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_home,
        backgroundColor: Colors.purpleAccent.withOpacity(0.8),
        children: [
          SpeedDialChild(
            child: Icon(Icons.account_balance_wallet),
            label: 'Lendings',
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LendingsPage()),
                ),
          ),
          SpeedDialChild(
            child: Icon(Icons.credit_card),
            label: 'Borrows', //Credits page
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreditsPage()),
                ),
          ),
          // SpeedDialChild(
          //   child: Icon(Icons.account_balance),
          //   label: 'Budgets',
          //   onTap: () =>
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => BudgetsPage()),
          //       ),
          // ),
          SpeedDialChild(
            child: Icon(Icons.receipt_long),
            label: 'View Records',
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListOfRecordsByMonthYear()),
                ),
          ),
          SpeedDialChild(
            child: Icon(Icons.settings),
            label: 'Settings',
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage()),
                ),
          ),
        ],
      ),
    );
  }
}
///////////////////////////////////////////////////////////////////

//
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/view_records.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Finance Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainScreen(),
//     );
//   }
// }
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0; // Tracks the selected tab
//
//   // List of primary pages for the BottomNavigationBar
//   final List<Widget> _pages = [
//     HomePage(),
//     IncomePage(),
//     ExpensePage(),
//   ];
//
//   // Function to handle BottomNavigationBar tap
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   bool _keepNavigationVisible = true; // Toggle for persistent navigation on all pages
//
//   Widget _buildPersistentNavigation() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Divider(height: 1, color: Colors.grey),
//           BottomNavigationBar(
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.attach_money),
//                 label: 'Income',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.money_off),
//                 label: 'Expense',
//               ),
//             ],
//           ),
//           SizedBox(height: 60), // Placeholder for FAB spacing
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Finance Tracker'),
//       ),
//       body: Stack(
//         children: [
//           _pages[_selectedIndex], // Display the selected page
//           if (_keepNavigationVisible) _buildPersistentNavigation(),
//         ],
//       ),
//       floatingActionButton: SpeedDial(
//         animatedIcon: AnimatedIcons.menu_close,
//         backgroundColor: Colors.blue,
//         children: [
//           SpeedDialChild(
//             child: Icon(Icons.account_balance_wallet),
//             label: 'Lendings',
//             onTap: () =>
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                     _keepNavigationVisible
//                         ? SecondaryPageWrapper(LendingsPage())
//                         : LendingsPage(),
//                   ),
//                 ),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.credit_card),
//             label: 'Credits',
//             onTap: () =>
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                     _keepNavigationVisible
//                         ? SecondaryPageWrapper(CreditsPage())
//                         : CreditsPage(),
//                   ),
//                 ),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.account_balance),
//             label: 'Budgets',
//             onTap: () =>
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                     _keepNavigationVisible
//                         ? SecondaryPageWrapper(BudgetsPage())
//                         : BudgetsPage(),
//                   ),
//                 ),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.receipt_long),
//             label: 'View Records',
//             onTap: () =>
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                     _keepNavigationVisible
//                         ? SecondaryPageWrapper(ListOfRecordsByMonthYear())
//                         : ListOfRecordsByMonthYear(),
//                   ),
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Wrapper to maintain persistent navigation on secondary pages
// class SecondaryPageWrapper extends StatelessWidget {
//   final Widget child;
//
//   SecondaryPageWrapper(this.child);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Secondary Page'),
//       ),
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0, // Default index for secondary pages
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.attach_money),
//             label: 'Income',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.money_off),
//             label: 'Expense',
//           ),
//         ],
//       ),
//       floatingActionButton: SpeedDial(
//         animatedIcon: AnimatedIcons.menu_close,
//         backgroundColor: Colors.blue,
//         children: [], // Optionally add FAB actions for secondary pages
//       ),
//     );
//   }
// }