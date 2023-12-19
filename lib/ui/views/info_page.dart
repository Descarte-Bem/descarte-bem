import 'package:decarte_bem/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: CustomAppBar(context: context,),
      body: const Center(
        child: Text('',//'O que será exibido na página?',
         style: TextStyle(
          fontSize: 20,
        ),)
      ),
    );
  }
}