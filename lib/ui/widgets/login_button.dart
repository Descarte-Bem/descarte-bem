import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserCredential? userCredential;
  bool isLogged = false;

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
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        debugPrint('Logado: ${userCredential!.user!.email}');
      } catch(e) {
        debugPrint("ERRO LOGANDO: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: signInWithGoogle,
      child: const Text("Entrar com o Google"),
    );
  }
}
