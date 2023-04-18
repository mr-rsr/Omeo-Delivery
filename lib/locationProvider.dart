import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ChangeNotifier {
  late double latitude;
  late double longitude;
  String getaddress = "";
  String userAddress = "";

  Future<String> getAddressFromLatLng() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        throw Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          throw Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      longitude = position.longitude;
      latitude = position.latitude;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    Placemark place = placemarks[0];

    String address =
        "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    getaddress = address.replaceAll("null", "");
    notifyListeners();
    return address;
  }

  addressFromLatlng(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    Placemark place = placemarks[0];
    String address =
        "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    userAddress = address.replaceAll("null", "");
    notifyListeners();
  }
}
