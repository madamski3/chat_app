import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final Function _setImage;
  const ImageSelector(this._setImage, {Key? key}) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File? _pickedImage;

  void _chooseImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      _pickedImage = File(image.path);
    });
    widget._setImage(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        OutlinedButton.icon(
          onPressed: _chooseImage,
          icon: const Icon(Icons.image),
          label: const Text('Choose an image'),
        ),
      ],
    );
  }
}
