// import 'package:flutter/material.dart';
// import 'package:floating_action_bubble/floating_action_bubble.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/view_expenses.dart';
// import 'pages/view_incomes.dart';
// import 'pages/view_budgets.dart';
// import 'pages/view_list.dart';
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
// class _BudgetTrackerAppState extends State<BudgetTrackerApp>
//     with SingleTickerProviderStateMixin {
//   int _selectedIndex = 2; // Set initial index to 2 for HomePage
//
//   final List<Widget> _pages = [
//     IncomePage(),
//     HomePage(),
//     ExpensePage(),
//     LendingsPage(),
//     CreditsPage(),
//     BudgetsPage(),
//     ListOfRecordsByMonthYear(),
//   ];
//
//   late Animation<double> _animation;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 200),
//     );
//
//     final curvedAnimation = CurvedAnimation(
//       curve: Curves.easeInOut,
//       parent: _animationController,
//     );
//
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
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
//         body: _pages[_selectedIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.attach_money),
//               label: 'Income',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.money_off),
//               label: 'Expense',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           unselectedItemColor: Colors.grey,
//           onTap: _onItemTapped,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         floatingActionButton: FloatingActionBubble(
//           items: <Bubble>[
//             Bubble(
//               title: "Credits",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.account_balance,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CreditsPage()),
//                 );
//                 _animationController.reverse();
//               },
//             ),
//             Bubble(
//               title: "Lendings",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.swap_horiz,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LendingsPage()),
//                 );
//                 _animationController.reverse();
//               },
//             ),
//             Bubble(
//               title: "Budgets",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.list,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BudgetsPage()),
//                 );
//                 _animationController.reverse();
//               },
//             ),
//             Bubble(
//               title: "View Records",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.account_circle_outlined,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListOfRecordsByMonthYear()),
//                 );
//                 _animationController.reverse();
//               },
//             ),
//           ],
//           animation: _animation,
//           onPress: () =>
//           _animationController.isCompleted
//               ? _animationController.reverse()
//               : _animationController.forward(),
//           iconColor: Colors.blue,
//           iconData: Icons.add,
//           backGroundColor: Colors.blue,
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// //import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/view_list.dart';
// import 'pages/view_budgets.dart';
// import 'pages/view_expenses.dart';
// import 'pages/view_incomes.dart';
//
//
// void main() {
//   runApp(BudgetTrackerApp());
// }
//
// class BudgetTrackerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Budget Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BudgetTrackerHomePage(),
//     );
//   }
// }
//
// class BudgetTrackerHomePage extends StatefulWidget {
//   @override
//   _BudgetTrackerHomePageState createState() => _BudgetTrackerHomePageState();
// }
//
// class _BudgetTrackerHomePageState extends State<BudgetTrackerHomePage>
//     with SingleTickerProviderStateMixin {
//   PersistentTabController _controller;
//   bool _isFabExpanded = false;
//   late AnimationController _animationController;
//   late Animation<Color?> _backgroundColor;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 2); // Home page index
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _backgroundColor = ColorTween(
//       begin: Colors.transparent,
//       end: Colors.black54,
//     ).animate(_animationController);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   List<Widget> _buildScreens() {
//     return [
//       IncomePage(),
//       ExpensePage(),
//       HomePage(),
//       LendingsPage(),
//       CreditsPage(),
//       BudgetsPage(),
//       ListOfRecordsByMonthYear(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.attach_money),
//         title: ("Income"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.money_off),
//         title: ("Expense"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.swap_horiz),
//         title: ("Lendings"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.account_balance),
//         title: ("Credits"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.list),
//         title: ("Budgets"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//     ];
//   }
//
//   void _toggleFab() {
//     setState(() {
//       _isFabExpanded = !_isFabExpanded;
//       if (_isFabExpanded) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }
//
//   Widget _buildFab() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (_isFabExpanded)
//           ...[
//             FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CreditsPage()),
//                 );
//                 _toggleFab();
//               },
//               child: Icon(Icons.account_balance),
//               tooltip: 'Credits',
//             ),
//             SizedBox(height: 10),
//             FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LendingsPage()),
//                 );
//                 _toggleFab();
//               },
//               child: Icon(Icons.swap_horiz),
//               tooltip: 'Lendings',
//             ),
//             SizedBox(height: 10),
//             FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BudgetsPage()),
//                 );
//                 _toggleFab();
//               },
//               child: Icon(Icons.list),
//               tooltip: 'Budgets',
//             ),
//             SizedBox(height: 10),
//             FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListOfRecordsByMonthYear()),
//                 );
//                 _toggleFab();
//               },
//               child: Icon(Icons.view_list),
//               tooltip: 'View List',
//             ),
//             SizedBox(height: 10),
//           ],
//         FloatingActionButton(
//           onPressed: _toggleFab,
//           child: Icon(_isFabExpanded ? Icons.close : Icons.add),
//           tooltip: 'Expand',
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         PersistentTabView(
//           context,
//           controller: _controller,
//           screens: _buildScreens(),
//           items: _navBarsItems(),
//           confineInSafeArea: true,
//           backgroundColor: Colors.white,
//           handleAndroidBackButtonPress: true,
//           resizeToAvoidBottomInset: true,
//           stateManagement: true,
//           hideNavigationBarWhenKeyboardShows: true,
//           decoration: NavBarDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             colorBehindNavBar: Colors.white,
//           ),
//           popAllScreensOnTapOfSelectedTab: true,
//           navBarStyle: NavBarStyle.style9,
//           onItemSelected: (index) {
//             if (_isFabExpanded) {
//               _toggleFab();
//             }
//           },
//         ),
//         if (_isFabExpanded)
//           FadeTransition(
//             opacity: _animationController,
//             child: GestureDetector(
//               onTap: _toggleFab,
//               child: Container(
//                 color: _backgroundColor.value,
//                 height: double.infinity,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//         Positioned(
//           bottom: 80,
//           right: 16,
//           child: _buildFab(),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:floating_action_bubble/floating_action_bubble.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/view_list.dart';
// import 'pages/view_budgets.dart';
// import 'pages/view_expenses.dart';
// import 'pages/view_incomes.dart';
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
// class _BudgetTrackerAppState extends State<BudgetTrackerApp>
//     with SingleTickerProviderStateMixin {
//   int _selectedIndex = 2; // Start with HomePage selected
//
//   final List<Widget> _pages = [
//     IncomePage(),
//     ExpensePage(),
//     HomePage(),
//     LendingsPage(),
//     CreditsPage(),
//     BudgetsPage(),
//     ListOfRecordsByMonthYear(),
//   ];
//
//   late Animation<double> _animation;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//
//     final curvedAnimation = CurvedAnimation(
//       curve: Curves.easeInOut,
//       parent: _animationController,
//     );
//
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
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
//         bottomNavigationBar: ConvexAppBar(
//           style: TabStyle.fixedCircle,
//           items: [
//             TabItem(icon: Icons.attach_money, title: 'Income'),
//             TabItem(icon: Icons.money_off, title: 'Expense'),
//             TabItem(icon: Icons.home, title: 'Home'),
//             TabItem(icon: Icons.swap_horiz, title: 'Lendings'),
//             TabItem(icon: Icons.account_balance, title: 'Credits'),
//             TabItem(icon: Icons.list, title: 'Budgets'),
//           ],
//           initialActiveIndex: _selectedIndex,
//           onTap: _onItemTapped,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         floatingActionButton: FloatingActionBubble(
//           items: <Bubble>[
//             Bubble(
//               title: "Credits",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.account_balance,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 setState(() {
//                   _selectedIndex = 4;
//                 });
//                 _animationController.reverse();
//               },
//             ),
//             Bubble(
//               title: "Lendings",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.swap_horiz,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 setState(() {
//                   _selectedIndex = 3;
//                 });
//                 _animationController.reverse();
//               },
//             ),
//             Bubble(
//               title: "Budgets",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.list,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 setState(() {
//                   _selectedIndex = 5;
//                 });
//                 _animationController.reverse();
//               },
//             ),
//             Bubble(
//               title: "List Records",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.list_alt,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 setState(() {
//                   _selectedIndex = 6;
//                 });
//                 _animationController.reverse();
//               },
//             ),
//           ],
//           animation: _animation,
//           onPress: () =>
//           _animationController.isCompleted
//               ? _animationController.reverse()
//               : _animationController.forward(),
//           iconColor: Colors.blue,
//           iconData: Icons.add,
//           backGroundColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/view_expenses.dart';
//
// //import 'pages/view_incomes.dart';
// //import 'pages/view_budgets.dart';
// //import 'pages/view_list.dart';
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
//   int _selectedIndex = 2; // Start with HomePage
//
//   final List<Widget> _pages = [
//     IncomePage(),
//     ExpensePage(),
//     HomePage(),
//     LendingsPage(),
//     CreditsPage(),
//     BudgetsPage(),
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
//         bottomNavigationBar: ConvexAppBar(
//           style: TabStyle.fixedCircle,
//           items: [
//             TabItem(icon: Icons.attach_money, title: 'Income'),
//             TabItem(icon: Icons.money_off, title: 'Expense'),
//             TabItem(icon: Icons.home, title: 'Home'),
//           ],
//           initialActiveIndex: _selectedIndex,
//           onTap: _onItemTapped,
//         ),
//         floatingActionButton: SpeedDial(
//           animatedIcon: AnimatedIcons.menu_close,
//           backgroundColor: Colors.blue,
//           overlayColor: Colors.black,
//           overlayOpacity: 0.5,
//           children: [
//             SpeedDialChild(
//               child: Icon(Icons.account_balance),
//               label: 'Credits',
//               onTap: () =>
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CreditsPage()),
//                   ),
//             ),
//             SpeedDialChild(
//               child: Icon(Icons.swap_horiz),
//               label: 'Lendings',
//               onTap: () =>
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LendingsPage()),
//                   ),
//             ),
//             SpeedDialChild(
//               child: Icon(Icons.list),
//               label: 'Budgets',
//               onTap: () =>
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => BudgetsPage()),
//                   ),
//             ),
//             SpeedDialChild(
//               child: Icon(Icons.calendar_today),
//               label: 'Records',
//               onTap: () =>
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ListOfRecordsByMonthYear()),
//                   ),
//             ),
//           ],
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       ),
//     );
//   }
// }

////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'pages/home_page.dart';
import 'pages/income_page.dart';
import 'pages/expense_page.dart';
import 'pages/lendings_page.dart';
import 'pages/credits_page.dart';
import 'pages/budgets_page.dart';
import 'pages/view_expenses.dart';
import 'pages/view_incomes.dart';
import 'pages/view_budgets.dart';
import 'pages/view_list.dart';

void main() {
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatefulWidget {
  @override
  _BudgetTrackerAppState createState() => _BudgetTrackerAppState();
}

class _BudgetTrackerAppState extends State<BudgetTrackerApp> {
  int _selectedIndex = 2; // Start with HomePage

  final List<Widget> _pages = [
    IncomePage(),
    ExpensePage(),
    HomePage(),
    CreditsPage(),
    ExpensePage(),
    IncomesPage(),
    LendingsPage(),
    ListOfRecordsByMonthYear(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _pages[_selectedIndex], // Display the selected page
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: [
            TabItem(icon: Icons.attach_money, title: 'Income'),
            TabItem(icon: Icons.money_off, title: 'Expense'),
            TabItem(icon: Icons.home, title: 'Home'),
          ],
          initialActiveIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.blue,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          children: [
            SpeedDialChild(
              child: Icon(Icons.account_balance),
              label: 'Credits',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreditsPage()),
                  ),
            ),
            SpeedDialChild(
              child: Icon(Icons.swap_horiz),
              label: 'Lendings',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LendingsPage()),
                  ),
            ),
            SpeedDialChild(
              child: Icon(Icons.list),
              label: 'Budgets',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BudgetsPage()),
                  ),
            ),
            SpeedDialChild(
              child: Icon(Icons.calendar_today),
              label: 'Records',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListOfRecordsByMonthYear()),
                  ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/view_expenses.dart';
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
//   int _selectedIndex = 1; // Start with HomePage
//
//   final List<Widget> _pages = [
//     IncomePage(),
//     HomePage(),
//     ExpensePage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   bool _isFABOpen = false;
//
//   void _toggleFAB() {
//     setState(() {
//       _isFABOpen = !_isFABOpen;
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
//         body: _pages[_selectedIndex],
//         bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           notchMargin: 6.0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.attach_money),
//                 onPressed: () => _onItemTapped(0),
//               ),
//               IconButton(
//                 icon: Icon(Icons.home),
//                 onPressed: () => _onItemTapped(1),
//               ),
//               IconButton(
//                 icon: Icon(Icons.money_off),
//                 onPressed: () => _onItemTapped(2),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Stack(
//           children: <Widget>[
//             Align(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(
//                 onPressed: _toggleFAB,
//                 child: Icon(_isFABOpen ? Icons.close : Icons.add),
//                 backgroundColor: Colors.blue,
//               ),
//             ),
//             _isFABOpen
//                 ? Positioned(
//               bottom: 80.0,
//               right: 16.0,
//               child: Column(
//                 children: <Widget>[
//                   _buildFABOption(
//                       Icons.account_balance, 'Credits', CreditsPage()),
//                   _buildFABOption(Icons.swap_horiz, 'Lendings', LendingsPage()),
//                   _buildFABOption(Icons.list, 'Budgets', BudgetsPage()),
//                   _buildFABOption(Icons.calendar_today, 'Records',
//                       ListOfRecordsByMonthYear()),
//                 ],
//               ),
//             )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFABOption(IconData icon, String label, Widget page) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.0),
//       child: FloatingActionButton(
//         mini: true,
//         child: Icon(icon),
//         onPressed: () {
//           setState(() {
//             _isFABOpen = false;
//           });
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => page),
//           );
//         },
//         heroTag: null,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // Import SpeedDial package
//
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/budgets_page.dart';
// import 'pages/view_expenses.dart'; // Assuming this is for viewing expenses (correct if mistaken)
// import 'pages/view_incomes.dart'; // Assuming this is for viewing incomes (correct if mistaken)
// import 'pages/view_budgets.dart';
// import 'pages/view_list.dart'; // Assuming this is for viewing a list of records
// //import 'pages/list_of_records_by_month_year.dart';
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
//   int _selectedIndex = 1; // Default to Home page
//
//   void _navigateToPage(BuildContext context, Widget page) {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => page));
//   }
//
//   final List<Widget> _pages = [
//     IncomePage(),
//     HomePage(), // Ensure Home page is at index 1
//     ExpensePage(),
//   ];
//
//   final List<SpeedDialChild> _speedDialItems = [
//     SpeedDialChild(
//       child: Icon(Icons.attach_money),
//       label: 'Credits',
//       onTap: () =>
//           _navigateToPage(context, CreditsPage()),
//     ),
//     SpeedDialChild(
//       child: Icon(Icons.swap_horiz),
//       label: 'Lendings',
//       onTap: () =>
//           _navigateToPage(context, LendingsPage()),
//     ),
//     SpeedDialChild(
//       child: Icon(Icons.list),
//       label: 'Budgets',
//       onTap: () => _navigateToPage(context, BudgetsPage()),
//     ),
//     SpeedDialChild(
//       child: Icon(Icons.calendar_view_day),
//       label: 'Records by Month/Year',
//       onTap: () => _navigateToPage(context, ListOfRecordsByMonthYear()),
//     ),
//   ]; // Use appropriate icons for viewing expenses/incomes/budgets if needed
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Budget Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         floatingActionButton: SpeedDial(
//           // Customize FAB appearance and behavior as desired
//           animatedIcon: AnimatedIcons.menu_close, // Optional animation
//           //icon: Icon(Icons.add), // Optional icon
//           children: _speedDialItems,
//         ),
//         body: Row(
//           children: <Widget>[
//             NavigationRail(
//               selectedIndex: _selectedIndex,
//               onDestinationSelected: _onItemTapped,
//               destinations: const [
//                 NavigationRailDestination(
//                   icon: Icon(Icons.attach_money),
//                   label: Text('Income'),
//                 ),
//                 NavigationRailDestination(
//                   icon: Icon(Icons.home),
//                   label: Text('Home'),
//                   //selectedLabelStyle: TextStyle(
//                   //    color: Colors.blue), // Highlight selected label
//                 ),
//                 NavigationRailDestination(
//                   icon: Icon(Icons.money_off),
//                   label: Text('Expense'),
//                 ),
//               ],
//             ),
//             VerticalDivider(thickness: 1),
//             // Add a divider between NavigationRail and content
//             Expanded(
//               child: IndexedStack(
//                 index: _selectedIndex,
//                 children: _pages,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }