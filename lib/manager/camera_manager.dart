import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/camera/camera_screen.dart';

class CameraService {
  static Future<String?> getImageByCamera(BuildContext context) async {
    XFile? xFile = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraScreen()));
    if (xFile != null) {
      return xFile.path.toString();
    }
  }
}
