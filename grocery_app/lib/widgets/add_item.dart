import 'package:flutter/material.dart';
import 'package:shop_app/widgets/new_item.dart';

class AddItem extends StatelessWidget {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/additem.png',
              fit: BoxFit.fill,
            ),
          ),
          NewItem(),
        ],
      ),
    );
  }
}
