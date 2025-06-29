import 'package:flutter/material.dart';
import 'package:places/Screens/add_place.dart';
import 'package:places/widgets/places_list.dart';

class Places extends StatelessWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[900],
          title: Text(
            "Your Places",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddPlace();
                  }));
                },
                icon: Icon(
                  Icons.add,
                  size: 26,
                  color: Colors.white,
                ))
          ],
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'images/places.png',
              fit: BoxFit.fill,
            ),
          ),
          PlacesList(),
        ]));
  }
}
