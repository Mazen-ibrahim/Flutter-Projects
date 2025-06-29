import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/models/grocery_item.dart';
import 'package:shop_app/providers/itemprovider.dart';

class GroceryGrid extends ConsumerWidget {
  final List<GroceryItem> items;
  const GroceryGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: ref.watch(itemprovider).length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final item = ref.read(itemprovider)[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Quantity: ${item.quantity}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: item.category.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item.category.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            ref
                                .read(itemprovider.notifier)
                                .incrementQuantity(index);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 36,
                            color: Color.fromARGB(255, 80, 185, 138),
                          )),
                      IconButton(
                          onPressed: () {
                            ref
                                .read(itemprovider.notifier)
                                .decrementQuantity(index);
                          },
                          icon: Icon(
                            Icons.minimize,
                            size: 36,
                            color: Color.fromARGB(255, 80, 185, 138),
                          )),
                      IconButton(
                          onPressed: () {
                            ref.read(itemprovider.notifier).deleteItem(item);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 36,
                            color: Color.fromARGB(255, 80, 185, 138),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
