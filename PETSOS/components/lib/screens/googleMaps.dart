import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> _controller = Completer();

class GoogleMapsScreen extends StatelessWidget {
  const GoogleMapsScreen({Key? key}) : super(key: key);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-33.356662, -70.670688),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) {
              //first calling is false
              //call "completer()"
              _controller.complete(controller);
            } else {
              //other calling, later is true,
              //don't call again completer()
            }
          },
        ),
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
