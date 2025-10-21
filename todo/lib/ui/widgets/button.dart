import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.label, required this.onTap})
    : super(key: key);

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white,fontSize: 23),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
