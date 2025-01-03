import 'dart:async';
import 'dart:math'; // Add this import for mathematical functions
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
 feature/Ayush
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
 main

class LocateScreen extends StatefulWidget {
  @override
  _LocateScreenState createState() => _LocateScreenState();
}

class _LocateScreenState extends State<LocateScreen> {
 feature/Ayush
  LatLng? userLocation;
  List<Marker> shopMarkers = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allShops = [
    {"name": "Vet Shop 1", "lat": 23.0225, "lon": 72.5714}, // Example shop in Ahmedabad, Gujarat
    {"name": "Vet Shop 2", "lat": 23.0275, "lon": 72.5845},
    {"name": "Vet Shop 3", "lat": 23.0325, "lon": 72.5960},
    // Add more shops here
  ];

  StreamSubscription<Position>? positionStream; // Nullable StreamSubscription

  LatLng _currentLocation = LatLng(0, 0); // Default location
  bool _isLoading = true;
 main

  @override
  void initState() {
    super.initState();
 feature/Ayush
    _checkLocationStatus();
    _addShopMarkers();
  }

  // Check if location services are enabled
  Future<void> _checkLocationStatus() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      _getUserLocation();
    } else {
      setState(() {
        userLocation = LatLng(23.0225, 72.5714); // Default location (Gujarat, Ahmedabad)
        isLoading = false;  // Stop loading when location is disabled
      });
    }
  }

  // Request user location
  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        setState(() {
          isLoading = false;
        });
        return;
      }
    }

    // Fetch the location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;  // Stop loading when location is fetched
      });

      // Start listening for continuous location updates
      positionStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // minimum distance (in meters) before updating location
        ),
      ).listen((Position position) {
        if (mounted) {
          setState(() {
            userLocation = LatLng(position.latitude, position.longitude);
          });
        }
      });

    } catch (e) {
      print('Error getting user location: $e');
      setState(() {
        // Fallback to Gujarat, India if location fetch fails
        userLocation = LatLng(23.0225, 72.5714); // Ahmedabad, Gujarat
        isLoading = false;
      });
    }
  }

  // Haversine formula to calculate distance between two points
  double _calculateDistance(LatLng start, LatLng end) {
    const R = 6371; // Radius of Earth in km
    var dLat = _toRadians(end.latitude - start.latitude);
    var dLon = _toRadians(end.longitude - start.longitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(start.latitude)) * cos(_toRadians(end.latitude)) *
        sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in km
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  // Add markers for nearby shops
  void _addShopMarkers() {
    shopMarkers = allShops.map((shop) {
      return Marker(
        point: LatLng(shop['lat'], shop['lon']),
        builder: (ctx) => Icon(Icons.location_on, color: Colors.red, size: 30),
      );
    }).toList();
  }

  @override
  void dispose() {
    // Cancel the stream subscription when the screen is disposed
    positionStream?.cancel();
    super.dispose();
  }

    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Get the user's current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching location: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
 main

  @override
  Widget build(BuildContext context) {
    // If location is available, calculate nearest shops
    if (userLocation != null) {
      allShops.sort((a, b) {
        double distanceA = _calculateDistance(userLocation!, LatLng(a['lat'], a['lon']));
        double distanceB = _calculateDistance(userLocation!, LatLng(b['lat'], b['lon']));
        return distanceA.compareTo(distanceB);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Locate Nearby Services'),
 feature/Ayush
        backgroundColor: Colors.orangeAccent,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search for a veterinary shop",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      center: userLocation ?? LatLng(23.0225, 72.5714), // Default to Gujarat (Ahmedabad)
                      zoom: 14.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(markers: [
                        if (userLocation != null)
                          Marker(
                            point: userLocation!,
                            builder: (ctx) => Icon(Icons.my_location, color: Colors.blue, size: 30),
                          ),
                        ...shopMarkers,
                      ]),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserLocation,
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.my_location),

        backgroundColor: Colors.orange,
 main
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: _currentLocation, // Center to user's location
                zoom: 13.0,
              ),
              children: [
                // Map tiles
                TileLayer(
                  urlTemplate:
                      "https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=13bfe10962d741fe9d94539c00331798",
                  additionalOptions: {
                    'apiKey': '13bfe10962d741fe9d94539c00331798',
                  },
                ),
                // Marker for current location
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation,
                      builder: (ctx) => Icon(Icons.location_on,
                          color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
