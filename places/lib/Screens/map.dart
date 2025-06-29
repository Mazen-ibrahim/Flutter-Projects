import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key, required this.location, required this.isSelecting});
  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? "Pick Your Location" : "Your Location"),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_pickedLocation);
                },
                icon: Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (newlocation) {
                setState(() {
                  _pickedLocation = newlocation;
                });
              },
        initialCameraPosition: CameraPosition(
          target: _pickedLocation ??
              LatLng(
                widget.location.latitude,
                widget.location.longitude,
              ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId("m1"),
                  position: LatLng(
                    widget.location.latitude,
                    widget.location.longitude,
                  ),
                ),
              },
      ),
    );
  }
}
