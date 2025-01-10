// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
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
//       home: HomePage(),
//       routes: {
//         '/income': (context) => IncomePage(),
//         '/expense': (context) => ExpensePage(),
//         '/lendings': (context) => LendingsPage(),
//         '/credits': (context) => CreditsPage(),
//         '/budget': (context) => BudgetsPage(),
//       },
//     );
//   }
// }
//

//good bottom nav bar
// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/income_page.dart';
import 'pages/expense_page.dart';
import 'pages/lendings_page.dart';
import 'pages/credits_page.dart';
import 'pages/budgets_page.dart';
import 'pages/settings_page.dart';
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
  int _selectedIndex = 0; // To track the selected bottom navigation bar item

  final List<Widget> _pages = [
    HomePage(),
    IncomePage(),
    ExpensePage(),
    LendingsPage(),
    CreditsPage(),
    BudgetsPage(),
    //SettingsPage(),
    //ExpensesByMonthYear(),
    //IncomesByMonthYear(),
    //BudgetsByMonthYear(),
    //ListPage(),
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[


            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Income',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money_off),
              label: 'Expense',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              activeIcon: Icon(Icons.home, color: Colors.blue),
              //backgroundColor: Colors.blue[100],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: 'Lendings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Credits',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Budgets',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.settings),
            //   //icon: Icon(Icons.add_home_work_outlined),
            //   label: 'Settings',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              //icon: Icon(Icons.add_home_work_outlined),
              label: 'View Expenses',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(color: Colors.amber[800]),
          unselectedLabelStyle: TextStyle(color: Colors.red),
          elevation: 0.0,
          //backgroundColor: Colors.blueGrey[800],
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
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
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   PersistentTabController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 0);
//   }
//
//   List<Widget> _buildScreens() {
//     return [
//       HomePage(),
//       IncomePage(),
//       ExpensePage(),
//       LendingsPage(),
//       CreditsPage(),
//       BudgetsPage(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
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
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       confineInSafeArea: true,
//       backgroundColor: Colors.white,
//       // Default is Colors.white.
//       handleAndroidBackButtonPress: true,
//       // Default is true.
//       resizeToAvoidBottomInset: true,
//       // This needs to be true if you want to move up the screen when keyboard appears.
//       stateManagement: true,
//       // Default is true.
//       hideNavigationBarWhenKeyboardShows: true,
//       // Recommended to set 'true' to hide the nav bar when keyboard appears.
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         colorBehindNavBar: Colors.white,
//       ),
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       itemAnimationProperties: ItemAnimationProperties(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: ScreenTransitionAnimation(
//         animateTabTransition: true,
//         curve: Curves.ease,
//         duration: Duration(milliseconds: 200),
//       ),
//       navBarStyle: NavBarStyle
//           .style6, // Choose the nav bar style with this property.
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
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
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late PersistentTabController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 0);
//   }
//
//   List<Widget> _buildScreens() {
//     return [
//       HomePage(),
//       IncomePage(),
//       ExpensePage(),
//       LendingsPage(),
//       CreditsPage(),
//       BudgetsPage(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
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
//   // @override
//   // Widget build(BuildContext context) {
//   //   return PersistentTabView(
//   //     context,
//   //     controller: _controller,
//   //     screens: _buildScreens(),
//   //     items: _navBarsItems(),
//   //     backgroundColor: Colors.white,
//   //     handleAndroidBackButtonPress: true,
//   //     resizeToAvoidBottomInset: true,
//   //     stateManagement: true,
//   //     hideNavigationBarWhenKeyboardShows: true,
//   //     decoration: NavBarDecoration(
//   //       borderRadius: BorderRadius.circular(10.0),
//   //       colorBehindNavBar: Colors.white,
//   //     ),
//   //     popAllScreensOnTapOfSelectedTab: true,
//   //     popActionScreens: PopActionScreensType.all,
//   //     itemAnimationProperties: ItemAnimationProperties(
//   //       duration: Duration(milliseconds: 200),
//   //       curve: Curves.ease,
//   //     ),
//   //     screenTransitionAnimation: ScreenTransitionAnimation(
//   //       animateTabTransition: true,
//   //       curve: Curves.ease,
//   //       duration: Duration(milliseconds: 200),
//   //     ),
//   //     navBarStyle: NavBarStyle.style6,
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       //confineInSafeArea: true,
//       backgroundColor: Colors.white,
//       handleAndroidBackButtonPress: true,
//       resizeToAvoidBottomInset: true,
//       stateManagement: true,
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         colorBehindNavBar: Colors.white,
//       ),
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       itemAnimationProperties: ItemAnimationProperties(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: ScreenTransitionAnimation(
//         animateTabTransition: true,
//         curve: Curves.ease,
//         duration: Duration(milliseconds: 200),
//       ),
//       navBarStyle: NavBarStyle.style6, // Choose the nav bar style
//     );
//   }
// }
//
//
// //navbar with bottom blue lines good 3star
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart'; // Correct import
// import 'pages/home_page.dart';
// import 'pages/income_page.dart';
// import 'pages/expense_page.dart';
// import 'pages/lendings_page.dart';
// import 'pages/credits_page.dart';
// import 'pages/budgets_page.dart';
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
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late PersistentTabController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         PersistentTabController(initialIndex: 0); // Initialize the controller
//   }
//
//   // Build list of screens for the PersistentTabView
//   List<Widget> _buildScreens() {
//     return [
//       HomePage(),
//       IncomePage(),
//       ExpensePage(),
//       LendingsPage(),
//       CreditsPage(),
//       BudgetsPage(),
//     ];
//   }
//
//   // Build navigation bar items
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
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
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       //confineInSafeArea: true,
//       // Ensures the nav bar is within the safe area
//       backgroundColor: Colors.white,
//       // Background color for the nav bar
//       handleAndroidBackButtonPress: true,
//       // Enable back button handling
//       resizeToAvoidBottomInset: true,
//       // Ensures layout is resized when keyboard appears
//       stateManagement: true,
//       // Maintains state of the navigation bar
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(10.0), // Border radius for nav bar
//         colorBehindNavBar: Colors.white, // Color behind the nav bar
//       ),
//       // itemAnimationProperties: ItemAnimationProperties(
//       //   duration: Duration(milliseconds: 200), // Animation duration for items
//       //   curve: Curves.ease, // Animation curve for items
//       // ),
//       // screenTransitionAnimation: ScreenTransitionAnimation(
//       //   animateTabTransition: true, // Tab transition animation
//       //   curve: Curves.ease, // Animation curve for screen transitions
//       //   duration: Duration(milliseconds: 200), // Duration of screen transition
//       // ),
//       navBarStyle: NavBarStyle.style3, // Choose the nav bar style
//     );
//   }
// }
