import 'package:geolocator/geolocator.dart';

Future<Position?> getLocation() async {
  try {
    // Request permission to access location
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Permission denied
      throw Exception('Permission to access location was denied.');
    }

    // Get current position
    Position userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Return the user location
    return userLocation;
  } catch (error) {
    // Handle error
    print('Error getting location: $error');
    return null;
  }
}
