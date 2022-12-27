import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

import 'logger.dart';

class LocationHelper {
  static Future<loc.LocationData> getLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error("NOT_ENABLED");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return Future.error("NOT_GRANTED");
      }
    }

    locationData = await location.getLocation();

    return locationData;
  }

  static Future<String> getAddressFromLatLng(
      {required double? latitude, required double? longitude}) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
        latitude!,
        longitude!,
      );
      Placemark place = p[0];
      return '${place.street}, ${place.locality}, ${place.postalCode},';
    } catch (e) {
      Logger.printLog(e.toString());
    }
    return "Unknown Location";
  }
}
