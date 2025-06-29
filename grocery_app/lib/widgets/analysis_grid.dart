import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/data/categories.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/providers/itemprovider.dart';

class AnalysisGrid extends ConsumerWidget {
  const AnalysisGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      itemCount: Categories.values.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index1) {
        return Card(
          color: const Color.fromARGB(255, 208, 241, 205),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: categories[Categories.values[index1]]!.color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  categories[Categories.values[index1]]!.title,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "In Stock",
                      style: TextStyle(fontSize: 24, color: Colors.green[300]),
                    ),
                    SizedBox(
                      width: 90,
                    ),
                    Text(
                      "Low Quantity",
                      style: TextStyle(fontSize: 24, color: Colors.orange[300]),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    Text(
                      "Out of Stock",
                      style: TextStyle(fontSize: 24, color: Colors.red[300]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final items = ref.watch(itemprovider);
                    final category = categories[Categories.values[index1]]!;
                    final filteredItems = items
                        .where((item) => item.category.title == category.title)
                        .toList();

                    return ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (ctx, index2) {
                        final item = filteredItems[index2];
                        Color? color;

                        if (item.quantity == 0) {
                          color = Colors.red[300];
                        } else if (item.quantity <= 20) {
                          color = Colors.orange[300];
                        } else {
                          color = Colors.green[300];
                        }

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
