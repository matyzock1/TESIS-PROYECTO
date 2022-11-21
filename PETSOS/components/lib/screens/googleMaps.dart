import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> _controller = Completer();

class GoogleMapsScreen extends StatefulWidget {
  GoogleMapsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(-33.45694, -70.64827),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      // ignore: avoid_print
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Marker _kGooglePlexMarker1 = Marker(
        markerId: const MarkerId("marker1"),
        infoWindow: InfoWindow(
            title: 'Clínica Veterinaria Huechuraba',
            snippet: "Llamar: +56227210922",
            onTap: () {
              FlutterPhoneDirectCaller.callNumber('+56227210922');
            }),
        icon: BitmapDescriptor.defaultMarker,
        position: const LatLng(-33.35225658429506, -70.67071054438819));

    Marker _kGooglePlexMarker2 = Marker(
      markerId: const MarkerId("marker2"),
      infoWindow: InfoWindow(
          title: 'Clínica Veterinaria Everest',
          snippet: "Llamar: +56232292114",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56232292114');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.3533768456075, -70.67655780885231),
    );

    Marker _kGooglePlexMarker3 = Marker(
      markerId: const MarkerId("marker3"),
      infoWindow: InfoWindow(
          title: 'Veterinaria Dr. House Vet',
          snippet: "Llamar: +56227211534",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56227211534');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.3533768456075, -70.67655780885231),
    );

    Marker _kGooglePlexMarker4 = Marker(
      markerId: const MarkerId("marker4"),
      infoWindow: InfoWindow(
          title: 'Clínica Veterinaria Boticaria Animal',
          snippet: "+56232092949",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56232092949');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.354954099084964, -70.67157962938873),
    );

    Marker _kGooglePlexMarker5 = Marker(
      markerId: const MarkerId("marker4"),
      infoWindow: InfoWindow(
          title: 'Centro Veterinario Pulgas',
          snippet: "+56966290537",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56966290537');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.36884358856657, -70.68064928112524),
    );

    Marker _kGooglePlexMarker6 = Marker(
      markerId: const MarkerId("marker4"),
      infoWindow: InfoWindow(
          title: 'Clinica Veterinaria Beverly Pets',
          snippet: "+56226231478",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56226231478');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.37178247013363, -70.6743836405556),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 6, 6),
        // on below line we have given title of app
        title: const Text(
          "PET-SOS",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: {
            _kGooglePlexMarker1,
            _kGooglePlexMarker2,
            _kGooglePlexMarker3,
            _kGooglePlexMarker4,
            _kGooglePlexMarker5,
            _kGooglePlexMarker6
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            // ignore: avoid_print
            print(value.latitude.toString() + " " + value.longitude.toString());
            _markers.add(Marker(
              markerId: const MarkerId("2"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(
                title: 'My Current Location',
              ),
            ));

            // specified current users location
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 15,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        label: const Text('Ubicación'),
        icon: const Icon(Icons.add_location_rounded),
        backgroundColor: const Color.fromARGB(255, 135, 6, 6),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
