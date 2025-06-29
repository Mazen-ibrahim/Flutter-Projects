import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/providers/itemprovider.dart';
import 'package:shop_app/widgets/grocery_grid.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/dashboard.jpg',
              fit: BoxFit.fill,
            ),
          ),
          GroceryGrid(items: ref.read(itemprovider) ),
        ],
      ),
    );
  }
}
