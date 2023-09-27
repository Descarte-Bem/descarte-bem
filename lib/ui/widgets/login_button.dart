import 'package:decarte_bem/services/google_sign_in.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late GoogleSignInHandler _googleSignInHandler;

  @override
  void initState() {
    super.initState();
    _googleSignInHandler = GoogleSignInHandler(context);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _googleSignInHandler.signInWithGoogle,
      child: const Text("Entrar com o Google"),
    );
  }
}
