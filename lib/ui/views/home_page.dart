import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

// Itens do popMenuButton
enum MenuItem { itemOne }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
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
              icon: const Icon(Icons.menu),
              color: Colors.black54,
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
