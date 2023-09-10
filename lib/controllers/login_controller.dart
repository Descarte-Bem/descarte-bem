import 'package:decarte_bem/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserCredential? userCredential;

  @override
  void onReady() {
    if (auth.currentUser != null) {
      debugPrint("${auth.currentUser!.displayName}");
      Get.offAndToNamed(Routes.HOME);
    }

    super.onReady();
  }

  Future<void> signInWithGoogle() async {
    if (auth.currentUser != null) {
      try {
        await auth.signOut();
        Get.snackbar(
          "Desconectado",
          "",
          backgroundColor: Colors.white,
        );
        update();
        Get.offAndToNamed(Routes.LOGIN);
        await googleSignIn.signOut();
      } catch(e) {
        debugPrint("ERRO deslogando:\n$e");
      }
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      debugPrint('googleUser: $googleUser');
      debugPrint('googleAuth: $googleAuth');
      userCredential = await auth.signInWithCredential(credential);
      Get.snackbar(
        "Conectado",
        auth.currentUser!.email!,
        backgroundColor: Colors.white,
      );
      update();
      Get.offAndToNamed(Routes.HOME);
    }
    debugPrint('userCredential: $userCredential');
    debugPrint('auth: $auth');
    debugPrint('email: ${userCredential!.user!.email}');

    update();
  }
}