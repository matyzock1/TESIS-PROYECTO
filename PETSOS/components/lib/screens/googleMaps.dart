import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> _controller = Completer();

class GoogleMapsScreen extends StatefulWidget {
  GoogleMapsScreen({Key? key}) : super(key: key);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-33.356662, -70.670688),
    zoom: 14.4746,
  );

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // late Position position;

  // void getMarkers(double lat, double long) {
  //   MarkerId markerId = MarkerId(lat.toString() + long.toString());
  //   Marker _marker = Marker(
  //       markerId: markerId,
  //       position: LatLng(lat, long),
  //       icon: BitmapDescriptor.defaultMarker,
  //       infoWindow: InfoWindow(snippet: 'Address'));
  //   setState(() {
  //     markers[markerId] = _marker;
  //   });
  // }

  // void getCurrentLocation() async {
  //   Position currentPosition =
  //       await GeolocatorPlatform.instance.getCurrentPosition();
  //   setState(() {
  //     position = currentPosition;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentLocation();
  // }

  // var currentLocation;

  // @override
  // void initState() {
  //   super.initState();
  //   Geolocator.getCurrentPosition().then((curreloc) {
  //     setState(() {
  //       currentLocation = curreloc;
  //     });
  //   });
  // }

  Widget build(BuildContext context) {
    final Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId("kGooglePlex"),
      infoWindow: InfoWindow(title: 'Piedra Roja'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.35783964645312, -70.67028139126742),
    );
    return WillPopScope(
      child: Scaffold(
        body: GoogleMap(
            // onTap: (tapped) async {
            //   var coordinated = geoco.Coordinates();
            //   getMarkers(tapped.latitude, tapped.longitude);
            //   await FirebaseFirestore.instance.collection('location').add({
            //     'latitude': tapped.latitude,
            //     'longitude': tapped.longitude,
            //     'Address': tapped
            //   });
            // },
            mapType: MapType.normal,
            markers: {_kGooglePlexMarker},
            initialCameraPosition: GoogleMapsScreen._kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              if (!_controller.isCompleted) {
                //first calling is false
                //call "completer()"
                _controller.complete(controller);
              } else {
                //other calling, later is true,
                //don't call again completer()
              }
            }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: const Text('Volver'),
          icon: const Icon(Icons.arrow_back),
          backgroundColor: const Color.fromARGB(222, 211, 43, 2),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
