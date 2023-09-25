import 'package:decarte_bem/ui/widgets/login_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  // TODO: checar se o usuário está logado ao iniciar o app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: const Center(
          child: LoginButton(),
        )
    );
  }
}
