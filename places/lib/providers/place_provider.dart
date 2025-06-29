import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';

class PlaceState extends StateNotifier<List<Place>> {
  PlaceState() : super([]);

  void addPlace(Place place) {
    state = [place, ...state];
  }

  void removePlace(Place place) {
    state = state.where((item) {
      return item != place;
    }).toList();
  }
}


final placeStateProvider = StateNotifierProvider<PlaceState,List<Place>>((ref){
  return PlaceState();
});