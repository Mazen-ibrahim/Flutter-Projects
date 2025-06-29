import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/data/categories.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/grocery_item.dart';
import 'package:shop_app/providers/dropdownprovider.dart';
import 'package:shop_app/providers/itemprovider.dart';

class NewItem extends ConsumerWidget {
  NewItem({super.key});

  final formkey = GlobalKey<FormState>();
  String? name;
  int? quantity;
  Categories? catagory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 520,
        child: Card(
          color: const Color.fromARGB(255, 208, 241, 205),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF2D6A4F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Add Item',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text(
                          'Item Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 80, 185, 138),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onSaved: (newValue) {
                        name = newValue;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1) {
                          return "Must be between 1 and 50 Characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          'Quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 80, 185, 138),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onSaved: (newValue) {
                        quantity = int.tryParse(newValue!);
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "Must be Valid Value";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    DropdownButtonFormField<Categories>(
                        elevation: 0,
                        focusColor: Colors.white60,
                        decoration: InputDecoration(
                          label: Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 80, 185, 138)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        value: ref.watch(dropprovider),
                        items: Categories.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 80, 185, 138),
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (newCat) {
                          ref.read(dropprovider.notifier).onchange(newCat);
                        },
                        onSaved: (newValue) {
                          catagory = ref.read(dropprovider);
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Must Choose Value";
                          }
                          return null;
                        }),
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        Expanded(
                          child: FloatingActionButton(
                            backgroundColor: Color(0xFF2D6A4F),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                GroceryItem item = GroceryItem(
                                    id: DateTime.now().toString(),
                                    name: name!,
                                    quantity: quantity!,
                                    category: categories[catagory]!);
                                ref.read(itemprovider.notifier).addItem(item);
                              }
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: FloatingActionButton(
                            backgroundColor: Color(0xFF2D6A4F),
                            onPressed: () {
                              formkey.currentState!.reset();
                            },
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
