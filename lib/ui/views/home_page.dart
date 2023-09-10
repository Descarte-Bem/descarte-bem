import 'package:decarte_bem/controllers/home_controller.dart';
import 'package:decarte_bem/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Itens do popMenuButton
enum MenuItem { itemOne }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.put(HomeController()),
      builder: (loginController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            centerTitle: true,
            actions: [
              GetBuilder<LoginController>(
                init: Get.put(LoginController()),
                builder: (loginController) {
                  return  PopupMenuButton<MenuItem>(
                    onSelected: (MenuItem item) {
                      loginController.signInWithGoogle();
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
                      PopupMenuItem<MenuItem>(
                        value: MenuItem.itemOne,
                        child: loginController.auth.currentUser != null
                            ? const Text("Sair")
                            : const Text("Entrar"),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: loginController.auth.currentUser != null
                        ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            loginController.auth.currentUser!.photoURL!,
                          ),
                        )
                        : IconButton(
                          onPressed: null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.person_rounded, color: Colors.white,),
                        ),
                    )
                  );
                }
              ),
            ],
          ),
          body: const Center(
            child: Text("Home Page"),
          )
        );
      }
    );
  }
}
