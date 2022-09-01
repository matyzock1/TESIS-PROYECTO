import 'dart:async';
import 'package:flutter/material.dart';
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
    const Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId("kGooglePlex"),
      infoWindow: InfoWindow(title: 'Piedra Roja'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.35783964645312, -70.67028139126742),
    );
    const Marker _kGooglePlexMarker2 = Marker(
      markerId: MarkerId("kGooglePlex"),
      infoWindow: InfoWindow(title: 'Clínica Veterinaria Huechuraba'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.35225658429506, -70.67071054438819),
    );
    const Marker _kGooglePlexMarker3 = Marker(
      markerId: MarkerId("kGooglePlex"),
      infoWindow: InfoWindow(title: 'El Roble Veterinaria (Huechuraba)'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-33.34705854795062, -70.66989515329783),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 174, 255),
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
            _kGooglePlexMarker,
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
        backgroundColor: const Color.fromARGB(255, 0, 174, 255),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
