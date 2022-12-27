import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'logger.dart';

class GeoLocationHelper {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Locationd services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
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
