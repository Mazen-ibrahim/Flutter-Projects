

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/data/categories.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/grocery_item.dart';

final List<GroceryItem> groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 20,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 50,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 40,
      category: categories[Categories.meat]!),
  GroceryItem(
      id: 'd',
      name: 'Cheddar Cheese',
      quantity: 25,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'e',
      name: 'Apples',
      quantity: 60,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'f',
      name: 'Chicken Breast',
      quantity: 35,
      category: categories[Categories.meat]!),
  GroceryItem(
      id: 'g',
      name: 'Carrots',
      quantity: 80,
      category: categories[Categories.vegetables]!),
  GroceryItem(
      id: 'h',
      name: 'Broccoli',
      quantity: 45,
      category: categories[Categories.vegetables]!),
  GroceryItem(
      id: 'i',
      name: 'Whole Wheat Bread',
      quantity: 30,
      category: categories[Categories.bakery]!),
  GroceryItem(
      id: 'j',
      name: 'Croissants',
      quantity: 15,
      category: categories[Categories.bakery]!),
  GroceryItem(
      id: 'k',
      name: 'Orange Juice',
      quantity: 22,
      category: categories[Categories.beverages]!),
  GroceryItem(
      id: 'l',
      name: 'Cola',
      quantity: 40,
      category: categories[Categories.beverages]!),
  GroceryItem(
      id: 'm',
      name: 'Potato Chips',
      quantity: 70,
      category: categories[Categories.snacks]!),
  GroceryItem(
      id: 'n',
      name: 'Chocolate Bar',
      quantity: 55,
      category: categories[Categories.snacks]!),
  GroceryItem(
      id: 'o',
      name: 'Toilet Paper',
      quantity: 100,
      category: categories[Categories.household]!),
  GroceryItem(
      id: 'p',
      name: 'Dish Soap',
      quantity: 30,
      category: categories[Categories.household]!),
];

class ItemNotifier extends StateNotifier<List<GroceryItem>> {
  ItemNotifier() : super(groceryItems);

  void addItem(GroceryItem item) {
    state = [...state, item];
  }

  void deleteItem(GroceryItem item) {
    List<GroceryItem> newGroceryItem = state.where((value) {
      return value != item;
    }).toList();

    state = newGroceryItem;
  }

  void incrementQuantity(index) {
    List<GroceryItem> updatedItems = List.from(state);
    GroceryItem item = updatedItems.elementAt(index);
    item.quantity += 1;
    updatedItems[index] = item;
    state = updatedItems;
  }

  void decrementQuantity(index) {
    List<GroceryItem> updatedItems = List.from(state);
    GroceryItem item = updatedItems.elementAt(index);
    if (item.quantity >= 1) {
      item.quantity -= 1;
      updatedItems[index] = item;
      state = updatedItems;
    }
  }
}

final itemprovider =
    StateNotifierProvider<ItemNotifier, List<GroceryItem>>((ref) {
  return ItemNotifier();
});

