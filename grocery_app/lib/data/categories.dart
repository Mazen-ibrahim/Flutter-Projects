import 'package:flutter/material.dart';
import '../models/category.dart';

const Map<Categories, Category> categories = {
  Categories.dairy: Category(title: 'Dairy', color: Colors.blue),
  Categories.fruit: Category(title: 'Fruit', color: Colors.orange),
  Categories.meat: Category(title: 'Meat', color: Colors.red),
  Categories.vegetables: Category(title: 'Vegetables', color: Colors.green),
  Categories.bakery: Category(title: 'Bakery', color: Colors.brown),
  Categories.beverages: Category(title: 'Beverages', color: Colors.teal),
  Categories.snacks: Category(title: 'Snacks', color: Colors.purple),
  Categories.household: Category(title: 'Household', color: Colors.grey),
};
