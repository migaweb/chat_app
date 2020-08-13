import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  Function(File pickeImage) imagePickFn;
  UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });

    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        GestureDetector(
          child: CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.grey,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage) : null,
          ),
          onTap: _pickImage,
        ),
        FlatButton.icon(
          textColor: theme.primaryColor,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          onPressed: _pickImage,
        )
      ],
    );
  }
}
