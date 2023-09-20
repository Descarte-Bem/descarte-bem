import 'package:decarte_bem/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: Get.put(LoginController()),
        builder: (loginController) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
              centerTitle: true,
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: loginController.signInWithGoogle,
                child: const Text("Google Login"),
              ),
            )
          );
        }
    );
  }
}
