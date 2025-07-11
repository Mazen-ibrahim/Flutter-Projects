import 'package:shop_app/models/category.dart';

class GroceryItem {
  final String id;
  final String name;
  int quantity;
  final Category category;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.category});
}
