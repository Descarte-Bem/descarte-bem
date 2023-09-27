import 'package:decarte_bem/services/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Itens do popMenuButton
enum MenuItem { login }

class CircularAvatarButton extends StatefulWidget {
  const CircularAvatarButton({super.key});

  @override
  State<CircularAvatarButton> createState() => _CircularAvatarButtonState();
}

class _CircularAvatarButtonState extends State<CircularAvatarButton> {
  late GoogleSignInHandler _googleSignInHandler;
  late bool isLogged;

  @override
  void initState() {
    super.initState();
    _googleSignInHandler = GoogleSignInHandler(context);
    setState(() {
      if (_googleSignInHandler.auth.currentUser != null) {
        isLogged = true;
      } else {
        isLogged = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (MenuItem item) async {
        if (item == MenuItem.login) {
          try {
            await _googleSignInHandler.signInWithGoogle();
            setState(() {
              if (_googleSignInHandler.auth.currentUser != null) {
                isLogged = true;
              } else {
                isLogged = false;
              }
            });
          } catch (e) {
            debugPrint("CircularAvatarButton error: $e");
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        PopupMenuItem<MenuItem>(
          value: MenuItem.login,
          child: isLogged
            ? const Text("Sair")
            : const Text("Entrar"),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: isLogged
          ? CircleAvatar(
            backgroundImage: NetworkImage(
              _googleSignInHandler.auth.currentUser!.photoURL!,
            ),
          )
          : IconButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0),),),
            ),
            icon: const Icon(
              Icons.person_rounded, color: Colors.white,),
          ),
      )
    );
  }
}
