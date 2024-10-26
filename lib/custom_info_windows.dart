import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindows extends StatefulWidget {
  const CustomInfoWindows({super.key});

  @override
  State<CustomInfoWindows> createState() => _CustomInfoWindowsState();
}

class _CustomInfoWindowsState extends State<CustomInfoWindows> {
  // Controller to manage the custom info window's behavior
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  // Set of markers to be displayed on the map
  Set<Marker> markers = {};

  // List of coordinates (LatLng) where markers will be placed
  final List<LatLng> latlongPoint = [
    const LatLng(23.751525, 450.391734), // karwan bazar1
    const LatLng(23.757988, 450.389329), // Farmget
    const LatLng(23.800795, 450.366953), // Pokhara
  ];

  // Corresponding names for the locations
  final List<String> locationNames = [
    "  Farmget",
    "  Boshundhara",
    "  Moripur",
  ];

  // Corresponding image URLs for the locations
  final List<String> locationImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Farmgate_metro_station.jpg/227px-Farmgate_metro_station.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhEg5kPPlBNn72s3UrdrP9kwhENXvJVOa1rQ&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpql2-LLXPVEyX4x11pXOSW7Eqqb5N3ESHWg&s",
  ];

  @override
  void initState() {
    super.initState();
    // Initialize and display the markers with custom info windows
    displayInfo();
  }

  // Function to add markers and custom info windows on the map
  displayInfo() {
    for (int i = 0; i < latlongPoint.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()), // Unique identifier for each marker
          icon: BitmapDescriptor.defaultMarker, // Default marker icon
          position: latlongPoint[i], // Position of the marker
          onTap: () {
            // When marker is tapped, show the custom info window
            _customInfoWindowController.addInfoWindow!(
              Container(
                color: Colors.white, // Background color of the info window
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the corresponding image for the location
                    Image.network(
                      locationImages[i],
                      height: 125,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                    // const SizedBox(height: 4), // Spacer between image and text
                    // Display the corresponding name for the location

                    Text(
                      locationNames[i],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const   Row(
                   children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Text("(5)")
                      ],
                    )
                  ],
                ),
              ),
              latlongPoint[
                  i], // Position where the info window should be displayed
            );
          },
        ),
      );
      setState(() {}); // Update the UI to reflect the added markers
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // GoogleMap widget to display the map
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                  23.751525, 450.391734), // Initial position of the camera (Pokhara)
              zoom: 7, // Initial zoom level
            ),
            markers: markers, // Set of markers to be displayed on the map
            onTap: (argument) {
              // Hide the custom info window when the map is tapped
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              // Update the position of the custom info window when the camera moves
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              // Assign the map controller to the custom info window controller
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          // Widget that manages the custom info windows
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 171, // Height of the custom info window
            width: 250, // Width of the custom info window
            offset: 35, // Offset to position the info window above the marker
          ),
        ],
      ),
    );
  }
}
