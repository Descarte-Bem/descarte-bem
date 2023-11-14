import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/models/farmacia_model.dart';
import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  List<FarmaciaModel> farmacyList = [];
  final MapController mapController = MapController();
  late final animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      mapController: mapController
  );

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Marker customMarker(double lat, double long, String nome){
    return Marker(
      point: LatLng(lat, long),
      builder: (_){
        return IconButton(
          icon: const Icon(Icons.medication_rounded, size: 30, color: Colors.red,),
          onPressed: (){
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    nome
                  ),
                );
              }
            );
          },
        );
      },
    );
  }
  
  Future<List<FarmaciaModel>> getFarmacias() async {
    return FirebaseFirestore.instance.collection('farmacias')
      .get()
      .then(
        (value) => value.docs.map(
          FarmaciaModel.fromQueryDocSnapshot
        ).toList()
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Descarte Bem"),
        titleTextStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 22),
        centerTitle: true,
        actions: const [
          CircularAvatarButton()
        ],
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            var latLng = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
            return FutureBuilder(
              future: getFarmacias(),
              builder: (context, farSnap){
                List<Marker> markerList = [];
                if (farSnap.hasData){
                  farmacyList = farSnap.data!;
                  for (var element in farmacyList) {
                    markerList.add(
                      customMarker(
                        element.localizacao.latitude,
                        element.localizacao.longitude,
                        element.nome
                      )
                    );
                  }
                }
                return FlutterMap(
                  mapController: animatedMapController.mapController,
                  options: MapOptions(
                    center: latLng,
                    zoom: 17.0,
                    minZoom: 5.0,
                    maxZoom: 18.0,
                    interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    AnimatedMarkerLayer(
                      markers: [
                        AnimatedMarker(
                          duration: const Duration(milliseconds: 500),
                          point: latLng,
                          builder: (_, __) {
                            return const Icon(
                              Icons.person,
                              size: 30,
                            );
                          },
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: markerList,
                    )
                  ],
                );
              }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info, size: 25,),
            label: 'Infomações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25,),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded, size: 25,),
            label: 'Mapa',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.pop(context);
          }
        },
        selectedItemColor: Colors.black54,
      ),
    );
  }
}
