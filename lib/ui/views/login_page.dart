import 'package:decarte_bem/ui/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (auth.currentUser != null) {
        debugPrint("Logado: ${auth.currentUser!.email}");
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    });

    super.initState();
  }

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
