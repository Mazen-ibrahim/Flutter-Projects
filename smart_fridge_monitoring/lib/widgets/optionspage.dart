import 'package:flutter/material.dart';
import 'package:smart_fridge_monitoring/data/users.dart';
import 'package:smart_fridge_monitoring/widgets/add_account.dart';
import 'package:smart_fridge_monitoring/widgets/add_fridge.dart';
import 'package:smart_fridge_monitoring/widgets/dashboardpage.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    DashBoardPage(),
    AddFridge(),
    AddAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: MediaQuery.of(context).size.width > 800,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                selectedIcon: Icon(Icons.dashboard, color: Colors.blue),
                label: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                selectedIcon: Icon(Icons.add, color: Colors.blue),
                label: Text(
                  'Add Fridge',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_circle),
                selectedIcon: Icon(Icons.account_circle, color: Colors.blue),
                label: Text(
                  'Add Account',
                  style: TextStyle(fontSize: 24),
                ),
              ),

            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              if (isAdmin) {
                setState(() {
                  _selectedIndex = value;
                });
              }
            },
            leading:
                const Icon(Icons.library_books, size: 40, color: Colors.blue),
            backgroundColor: Colors.grey.shade200,
            selectedIconTheme:
                const IconThemeData(color: Colors.blue, size: 24),
            unselectedIconTheme:
                const IconThemeData(color: Colors.grey, size: 24),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
