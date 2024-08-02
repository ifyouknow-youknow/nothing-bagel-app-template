import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapView extends StatefulWidget {
  final List<LatLng> locations;
  final double height;
  final double delta;
  final bool isScrolling;

  const MapView({
    Key? key,
    required this.locations,
    this.height = 300,
    this.delta = 0.001,
    this.isScrolling = false,
  }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LatLngBounds? _bounds;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _setMarkers();
  }

  Future<void> _checkLocationPermission() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      print("Location permission granted");
    } else {
      print("Location permission denied");
    }
  }

  void _setMarkers() {
    setState(() {
      for (var location in widget.locations) {
        _markers.add(Marker(
          markerId: MarkerId(location.toString()),
          position: location,
        ));
      }
    });
  }

  void _setMapBounds() {
    if (widget.locations.isNotEmpty) {
      double southWestLat = widget.locations.first.latitude;
      double southWestLng = widget.locations.first.longitude;
      double northEastLat = widget.locations.first.latitude;
      double northEastLng = widget.locations.first.longitude;

      for (var location in widget.locations) {
        if (location.latitude < southWestLat) southWestLat = location.latitude;
        if (location.longitude < southWestLng)
          southWestLng = location.longitude;
        if (location.latitude > northEastLat) northEastLat = location.latitude;
        if (location.longitude > northEastLng)
          northEastLng = location.longitude;
      }

      double delta = widget.delta;

      _bounds = LatLngBounds(
        southwest: LatLng(southWestLat - delta, southWestLng - delta),
        northeast: LatLng(northEastLat + delta, northEastLng + delta),
      );

      if (_mapController != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLngBounds(_bounds!, 50),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _setMapBounds();
        },
        initialCameraPosition: CameraPosition(
          target: widget.locations.isNotEmpty
              ? widget.locations.first
              : const LatLng(0, 0),
          zoom: 10,
        ),
        markers: _markers,
        scrollGesturesEnabled: widget.isScrolling,
      ),
    );
  }
}
