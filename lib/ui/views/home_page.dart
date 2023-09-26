import 'package:decarte_bem/ui/widgets/circular_avatar_button.dart';
import 'package:flutter/material.dart';

// Itens do popMenuButton
enum MenuItem { itemOne }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: const [
          CircularAvatarButton()
        ],
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
