import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transit_app/common_layout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  static const initialPosition =
      LatLng(-1.2921, 36.8219); // Centered on Nairobi

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  TextEditingController _searchController = TextEditingController();

  // Added variable to store bus fare
  String busFare = '';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> fetchBusStations(String destination) async {
    final response = await http.get(Uri.parse(
        'http://192.168.100.3:5000/bus_stations?destination=$destination'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      List<dynamic> busStations = responseData['bus_stations'];
      busFare = responseData['bus_fare'].toString();

      setState(() {
        _markers.clear();
        for (var station in busStations) {
          _markers.add(
            Marker(
              markerId: MarkerId(station['name']),
              position: LatLng(station['latitude'], station['longitude']),
              infoWindow: InfoWindow(
                title: station['name'],
                snippet:
                    '${station['description']} \nPeak: ${station['peak']} \nOff-peak: ${station['off_peak']}',
              ),
            ),
          );
        }
      });

      if (busStations.isNotEmpty && mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(busStations[0]['latitude'], busStations[0]['longitude']),
            14.0,
          ),
        );
      }
    } else {
      throw Exception('Failed to load bus stations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Enter destination',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        fetchBusStations(_searchController.text);
                      },
                    ),
                  ],
                ),
                if (busFare.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Bus Fare: $busFare'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: GoogleMapPage.initialPosition,
                zoom: 13,
              ),
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
