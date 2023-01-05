import 'package:geolocator/geolocator.dart';
import 'package:outkey_challenge/models/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;

class PermissionRepository {
  static Future<bool> requestLocationPermission() async {
    var status = await permission_handler.Permission.location.request();
    return status.isGranted;
  }

  static Future<Location> get location async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest,
    );
    return Location(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
