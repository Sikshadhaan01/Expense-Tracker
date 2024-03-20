import 'package:expense_tracker/pages/homepage.dart';
import 'package:expense_tracker/pages/login_page.dart';
import 'package:expense_tracker/pages/signup_page.dart';
import 'package:expense_tracker/pages/transactions_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List _pages = [
    const Homepage(),
    const TransactionPage(),
    const Text("Page 3"),
    const Text("Page 4"),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages.elementAt(_selectedIndex),),
      bottomNavigationBar: BottomNavigationBar(
        // selectedFontSize: 8,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFFe53946),
        currentIndex: _selectedIndex,
        // fixedColor: Colors.blue,
        onTap: _onItemTapped,
        items: _navBarItems(),
        backgroundColor: const Color(0xFF1e3557),
      ),
    );
  }
}

List<BottomNavigationBarItem> _navBarItems() {
  return [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.square_stack_3d_down_right),
        label: 'Transactions'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.pie_chart_sharp), label: 'Budgets'),
    const BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
  ];
}
