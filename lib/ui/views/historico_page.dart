import 'package:flutter/material.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({Key? key}) : super(key: key);

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     body:Center(
        child: Text('Historico',
        style: TextStyle(
          fontSize: 20,
          )
        )
     ),
    );
  }
}