import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _pickedImageFile;

  void _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 150,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile == null
              ? null
              : FileImage(_pickedImageFile!),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image,size: 18,color: Colors.teal,),
          label: Text(
            "Add Photo",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
