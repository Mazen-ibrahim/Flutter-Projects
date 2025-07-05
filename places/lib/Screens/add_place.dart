import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:places/Screens/map.dart';
import 'package:places/models/place.dart';
import 'package:places/providers/place_provider.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final TextEditingController titlecontroller = TextEditingController();
  File? selectedImage;
  PlaceLocation? pickedlocation;

  void _setImage(File image) {
    setState(() {
      selectedImage = image;
    });
  }

  void _setlocation(PlaceLocation location) {
    setState(() {
      pickedlocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber[900],
        title: const Text(
          "Add Place",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/add_place.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TitleInput(titlecontroller: titlecontroller),
                    ImageInput(selectedImage: _setImage),
                    SizedBox(
                      height: 5,
                    ),
                    LocationInput(selectedLocation: _setlocation),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 70,
            right: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AddButton(
                titlecontroller: titlecontroller,
                image: selectedImage,
                location: pickedlocation,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddButton extends ConsumerWidget {
  const AddButton({
    super.key,
    required this.titlecontroller,
    required this.image,
    required this.location,
  });

  final TextEditingController titlecontroller;
  final File? image;
  final PlaceLocation? location;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      width: 250,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Place",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          final title = titlecontroller.text;
          if (title.isEmpty || image == null || location == null) return;

          ref.read(placeStateProvider.notifier).addPlace(
              Place(title: title, image: image!, location: location!));
          titlecontroller.clear();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[900],
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.selectedLocation});
  final void Function(PlaceLocation location) selectedLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;
  bool _isGettingLocation = false;
  String? address;

  String get locationImage {
    if (pickedLocation == null) {
      return "";
    }
    final lat = pickedLocation!.latitude;
    final lng = pickedLocation!.longitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=AIzaSyA334XNXSqYZ0JpNeScYW8PV0dK8EzYGM0";
  }

  Future<void> _savelocation(double longitude, double latitude) async {
    final Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$longitude,$latitude&key=AIzaSyA334XNXSqYZ0JpNeScYW8PV0dK8EzYGM0");
    final Response response = await http.get(url);

    final Map<String, dynamic> resdata;
    final String address;

    if (response.statusCode == 200) {
      resdata = json.decode(response.body);
    } else {
      return;
    }

    if (resdata.isEmpty) {
      address = resdata["results"][0]["formatted_address"];
    } else {
      return;
    }

    setState(() {
      pickedLocation = PlaceLocation(
          longitude: longitude, latitude: latitude, address: address);
      _isGettingLocation = false;
    });

    widget.selectedLocation(pickedLocation!);
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    if (!serviceEnabled) {
      return;
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    if (permissionStatus != PermissionStatus.granted) {
      return;
    }

    setState(() {
      _isGettingLocation = true;
    });

    LocationData locationdata = await location.getLocation();
    final lat = locationdata.latitude;
    final lng = locationdata.longitude;
    if (lat == null || lng == null) {
      return;
    }

    _savelocation(lng, lat);
  }

  void onSelectMap() async {
    LatLng? pickedlocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
            builder: (ctx) => MapScreen(
                location: PlaceLocation(
                    longitude: -122.07, latitude: 37.422, address: ""),
                isSelecting: true)));

    if (pickedlocation == null) {
      return;
    }

    _savelocation(pickedlocation.longitude, pickedlocation.latitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      address == null ? "No Location Selected" : address!,
      style: TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
    );

    if (pickedLocation != null) {
      content = Image.network(
        locationImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );
    }
    if (_isGettingLocation) {
      content = Center(
        child: CircularProgressIndicator(
          color: Colors.amber[900],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(4),
      child: Column(
        children: [
          content,
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: getCurrentLocation,
                label: Text("Current Location",
                    style: TextStyle(
                      color: Colors.amber[900],
                    )),
                icon: Icon(
                  Icons.location_on,
                  size: 24,
                  color: Colors.amber[900],
                ),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: onSelectMap,
                label: Text(
                  "Map Location",
                  style: TextStyle(
                    color: Colors.amber[900],
                  ),
                ),
                icon: Icon(
                  Icons.map,
                  size: 24,
                  color: Colors.amber[900],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TitleInput extends StatelessWidget {
  const TitleInput({super.key, required this.titlecontroller});
  final TextEditingController titlecontroller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      controller: titlecontroller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        label: Text(
          "Title",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.selectedImage});
  final void Function(File image) selectedImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectImage;

  void _saveImage() async {
    final imagepicker = ImagePicker();
    final pickedimage =
        await imagepicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedimage == null) return;

    setState(() {
      selectImage = File(pickedimage.path);
    });

    widget.selectedImage(selectImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
      onPressed: _saveImage,
      icon: Icon(
        Icons.camera_alt_outlined,
        size: 24,
        color: Colors.amber[900],
      ),
      label: Text(
        "Take Picture",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.amber[900]),
      ),
    );

    if (selectImage != null) {
      content = GestureDetector(
        onTap: _saveImage,
        child: Image.file(
          selectImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      height: selectImage == null ? 100 : 400,
      width: double.infinity,
      decoration: BoxDecoration(),
      alignment: Alignment.center,
      child: content,
    );
  }
}
