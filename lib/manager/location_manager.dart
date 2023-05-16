import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationManager {
  static Future<Position?> getGPSLocation() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .timeout(const Duration(seconds: 4));
      return position;
    } on TimeoutException catch (_) {
      print(_);
      return position;
    } catch (e) {
      print(e);
      return position;
    }
  }
}