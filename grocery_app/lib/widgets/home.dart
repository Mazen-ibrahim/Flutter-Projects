import 'package:flutter/material.dart';
import 'package:shop_app/data/global_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        SafeArea(
          child: NavigationRail(
            backgroundColor:
                const Color.fromARGB(255, 80, 114, 96), // Pale Green background
            selectedIconTheme: const IconThemeData(
                color: Color(0xFF2D6A4F)), // Forest Green icon
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            selectedLabelTextStyle: const TextStyle(
              color: Color(0xFF2D6A4F),
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelTextStyle: const TextStyle(
              color: Colors.grey,
            ),
            leading: Icon(
              Icons.dashboard,
              size: 32,
              color: Colors.white,
            ),
            extended: true,
            destinations: [
              NavigationRailDestination(
                icon: Icon(
                  Icons.home,
                  size: 24,
                  color: Colors.white,
                ),
                label: Text(
                  'Dashboard',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  'Add Item',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.analytics_sharp,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  'Analysis',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white),
                ),
              ),
            ],
            selectedIndex: selectedindex,
            onDestinationSelected: (value) {
              setState(() {
                selectedindex = value;
              });
            },
          ),
        ),
        Expanded(child: pages[selectedindex])
      ],
    ));
  }
}
