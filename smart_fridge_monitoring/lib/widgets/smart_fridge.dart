import 'package:flutter/material.dart';
import 'package:smart_fridge_monitoring/widgets/dashboardpage.dart';
import 'package:smart_fridge_monitoring/widgets/loginpage.dart';
import 'package:smart_fridge_monitoring/widgets/optionspage.dart';

class SmartFridge extends StatelessWidget {
  const SmartFridge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Fridge Monitoring ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginPage(),
      routes: {
        '/dashboard': (context) => const DashBoardPage(),
        '/options': (context) => const OptionsPage(),
      },
    );
  }
}
