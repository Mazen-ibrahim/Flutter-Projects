import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/Screens/places_details.dart';
import 'package:places/providers/place_provider.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(placeStateProvider).isEmpty) {
      return Center(
        child: Text(
          "No Places Added yet",
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: ref.watch(placeStateProvider).length,
        itemBuilder: (ctx, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  FileImage(ref.read(placeStateProvider)[index].image),
              radius: 30,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlaceDetails(
                        place: ref.read(placeStateProvider)[index],
                      )));
            },
            title: Text(
              ref.read(placeStateProvider)[index].title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.white),
            ),
            subtitle:Text(
              ref.read(placeStateProvider)[index].location.address,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ), 

          );
        },
      ),
    );
  }
}
