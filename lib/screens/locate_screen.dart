import 'dart:async';
import 'dart:math'; // Mathematical functions
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocateScreen extends StatefulWidget {
  @override
  _LocateScreenState createState() => _LocateScreenState();
}

class _LocateScreenState extends State<LocateScreen> {
  LatLng? userLocation;
  List<Marker> shopMarkers = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allShops = [
    {"name": "Vet Shop 1", "lat": 23.0225, "lon": 72.5714},
    {"name": "Vet Shop 2", "lat": 23.0275, "lon": 72.5845},
    {"name": "Vet Shop 3", "lat": 23.0325, "lon": 72.5960},
  ];

  StreamSubscription<Position>? positionStream; // Stream for continuous location updates

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _addShopMarkers();
  }

  // Initialize location services
  Future<void> _initializeLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultLocation();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        _setDefaultLocation();
        return;
      }
    }

    _getUserLocation();
  }

  // Set a default location if location services are disabled
  void _setDefaultLocation() {
    setState(() {
      userLocation = LatLng(23.0225, 72.5714); // Ahmedabad, Gujarat
      isLoading = false;
    });
  }

  // Get the user's current location
  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });

      // Start listening for continuous location updates
      positionStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // Minimum distance before updating location
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
      _setDefaultLocation();
    }
  }

  // Haversine formula to calculate distance between two points
  double _calculateDistance(LatLng start, LatLng end) {
    const R = 6371; // Radius of Earth in km
    var dLat = _toRadians(end.latitude - start.latitude);
    var dLon = _toRadians(end.longitude - start.longitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(start.latitude)) *
            cos(_toRadians(end.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
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
    positionStream?.cancel(); // Cancel stream subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.orangeAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
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
                      center: userLocation ?? LatLng(23.0225, 72.5714), // Default to Ahmedabad, Gujarat
                      zoom: 14.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          if (userLocation != null)
                            Marker(
                              point: userLocation!,
                              builder: (ctx) => Icon(Icons.my_location, color: Colors.blue, size: 30),
                            ),
                          ...shopMarkers,
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserLocation,
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.my_location),
      ),
    );
  }
}
