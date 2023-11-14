import 'package:decarte_bem/ui/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;

  Future<bool> checkUserLoggedIn() async {
    return auth.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/5),
              child: SvgPicture.asset('assets/Logov2.svg'),
            ),
            FutureBuilder<bool>(
              future: checkUserLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  });
                  return Container();
                } else {
                  return const Center(
                    child: LoginButton(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
