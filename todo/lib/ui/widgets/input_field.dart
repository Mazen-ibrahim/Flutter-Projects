import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.icon,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            readOnly: icon != null,
            cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
            style: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.titleMedium,
              suffixIcon: icon,
              filled: true,
              fillColor: Get.isDarkMode ? Colors.grey[700] : Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
