import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/models/category.dart';

class DropNotifier extends StateNotifier<Categories?> {
  DropNotifier() : super(null);

  void onchange(Categories? value) {
    state = value;
  }
}

final dropprovider =
    StateNotifierProvider<DropNotifier,Categories?>((ref) {
  return DropNotifier();
});