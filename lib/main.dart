import 'package:decarte_bem/firebase_options.dart';
import 'package:decarte_bem/ui/views/faq_page.dart';
import 'package:decarte_bem/ui/views/home_page.dart';
import 'package:decarte_bem/ui/views/login_page.dart';
import 'package:decarte_bem/ui/views/instrucoes_page.dart';
import 'package:decarte_bem/ui/views/historico_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

//Nao deixar linha com mais de 80 caracteres
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Descarte Bem',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const LoginPage(),
      routes: {
        '/FAQ': (context) => const FAQPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/historico': (context) => const HistoricoPage(),
        '/instrucoes': (context) => const InstrucoesPage(),
      },
    );
  }
}
