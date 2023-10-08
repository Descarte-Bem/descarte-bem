import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final MapController mapController = MapController();
  late final animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      mapController: mapController
  );

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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded, size: 30,),
              color: Colors.black54,
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: FlutterMap(
        mapController: animatedMapController.mapController,
        options: MapOptions(
          center: LatLng(-22.906182239955363, -43.13348510810126),
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
                point: LatLng(-22.906182239955363, -43.13348510810126),
                width: 17,
                height: 17,
                builder: (_, __) {
                  return const Icon(
                    Icons.flag,
                    size: 50,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      drawer: const Drawer(
        child: SafeArea(
            child: ListTile(
              title: Text('Menu Lateral'),
            )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Mapa',
          ),
        ],
        onTap: (int index) {},
        selectedItemColor: Colors.black54,
      ),
    );
  }
}
