import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryManager {
  static Future<XFile?> getImage(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    try {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 15,
      );
      return pickedFile;
    } catch (e) {
      return pickedFile;
    }
  }

  static Future<XFile?> getCamera(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    try {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 15,
      );
      return pickedFile;
    } catch (e) {
      return pickedFile;
    }
  }
}
