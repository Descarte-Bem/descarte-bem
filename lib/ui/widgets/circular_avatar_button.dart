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

  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserCredential? userCredential;
  bool isLogged = true;

  Future<void> signInWithGoogle() async {
    if (auth.currentUser != null) {
      try {
        await auth.signOut();
        await googleSignIn.signOut();
        setState(() {
          isLogged = false;
        });
        debugPrint('Deslogado');
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } catch(e) {
        debugPrint("ERRO DESLOGANDO: $e");
      }
    } else {
      try {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        userCredential = await auth.signInWithCredential(credential);
        setState(() {
          isLogged = true;
        });
        debugPrint('Logado: ${userCredential!.user!.email}');
      } catch(e) {
        debugPrint("ERRO LOGANDO: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
        onSelected: (MenuItem item) {
          if (item == MenuItem.login) {
            signInWithGoogle();
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
              auth.currentUser!.photoURL!,
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
