import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decarte_bem/models/farmacia_model.dart';
import 'package:decarte_bem/ui/views/qrcodescan.dart';
import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../models/descarte_model.dart';

class MapPage extends StatefulWidget {
  final Function updateHome;
  const MapPage({super.key, required this.updateHome});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  DescarteModel? pendingDiscard;
  List<FarmaciaModel> farmacyList = [];
  final MapController mapController = MapController();

  late final animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      mapController: mapController
  );

  getDistance(FarmaciaModel farmacia, Position position){
    return Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      farmacia.localizacao.latitude,
      farmacia.localizacao.longitude
    );
  }

  getPendingDiscard() async {
    List<DescarteModel> discardList = await FirebaseFirestore.instance
        .collection('descartes')
        .where('usuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) =>
        value.docs.map(DescarteModel.fromQueryDocSnapshot).toList());
    for (var discard in discardList) {
      if (discard.farmaciaId == null) {
        setState(() {
          pendingDiscard = discard;
        });
        return;
      }
    }
    setState(() {
      pendingDiscard = null;
    });
  }


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

  Marker customMarker(int distance, double lat, double long, String nome){
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
                    '$nome \n${distance}m',
                    textAlign: TextAlign.center,
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey.shade700,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                    element.distance = getDistance(element, snapshot.data!);
                    markerList.add(
                      customMarker(
                        element.distance!.round(),
                        element.localizacao.latitude,
                        element.localizacao.longitude,
                        element.nome
                      )
                    );
                  }
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.778,
                        child: FlutterMap(
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
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await getPendingDiscard();
                          if (pendingDiscard == null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Faça um novo descarte primeiro!'),
                              )
                            );
                          } else {
                            if(context.mounted){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRCodePage(updateHome: widget.updateHome, pendingDiscard: pendingDiscard,)
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                          ),
                          child: Center(
                            child: Text(
                              'Concluir descarte',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Farmácias próximas',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width*0.07,
                                    color: Colors.red.shade900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: SizedBox(
                                  height: MediaQuery.of(context).size.height*0.5,
                                  width: MediaQuery.of(context).size.width*0.8,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) => Divider(
                                      color: Colors.black,
                                    ),
                                    itemCount: farmacyList.length,
                                    itemBuilder: (context, index){
                                      print('Lista[$index] antes');
                                      print(farmacyList[index].distance);
                                      farmacyList.sort((a, b) => a.distance!.compareTo(b.distance!));
                                      print('Lista[$index] depois');
                                      print(farmacyList[index].distance);
                                      return ListTile(
                                        onTap: (){
                                          Navigator.pop(context);
                                          animatedMapController.mapController.move(
                                            LatLng(
                                              farmacyList[index].localizacao.latitude,
                                              farmacyList[index].localizacao.longitude
                                            ),
                                            17.0,
                                          );
                                        },
                                        title: Text(
                                          '${farmacyList[index].nome} \n${farmacyList[index].distance!.round()}m',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                          ),
                          child: Center(
                            child: Text(
                              'Farmácias próximas',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red.shade700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
