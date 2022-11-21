import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          title: 'Veterinaria Piedra Roja',
          snippet: "Llamar: +56227250196",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56227250196');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: const LatLng(-33.35783964645312, -70.67028139126742),
    );

    Marker _kGooglePlexMarker2 = Marker(
      markerId: const MarkerId("marker1"),
      infoWindow: InfoWindow(
          title: 'El Roble Veterinaria (Huechuraba)',
          snippet: "Llamar: +56222488901",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56222488901');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: const LatLng(-33.346709049302405, -70.66994884641845),
    );

    Marker _kGooglePlexMarker3 = Marker(
      markerId: const MarkerId("marker1"),
      infoWindow: InfoWindow(
          title: 'Clínica Veterinaria Huechuraba',
          snippet: "Llamar: +56227210922",
          onTap: () {
            FlutterPhoneDirectCaller.callNumber('+56227210922');
          }),
      icon: BitmapDescriptor.defaultMarker,
      position: const LatLng(-33.3520182195868, -70.67070433073035),
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
            _kGooglePlexMarker3
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
