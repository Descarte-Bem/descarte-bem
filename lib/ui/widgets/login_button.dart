import 'package:decarte_bem/services/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

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
    return SignInButton(
      Buttons.GoogleDark,
      onPressed: _googleSignInHandler.signInWithGoogle,
      text: 'Entrar com o google',
      padding: const EdgeInsets.all(5),
      elevation: 0.0,
    );
  }
}
