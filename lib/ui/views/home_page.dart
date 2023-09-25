import 'package:decarte_bem/ui/widgets/login_button.dart';
import 'package:flutter/material.dart';

// Itens do popMenuButton
enum MenuItem { itemOne }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // TODO: criar widget mostrando foto do usuário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: const [
          LoginButton()
        ],
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
