import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/descarte_model.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({Key? key}) : super(key: key);

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  List<DescarteModel> discardList = [];

  @override
  void initState() {
    super.initState();
    getDiscards();
  }

  getDiscards() async {
    discardList = await FirebaseFirestore.instance
        .collection('descartes')
        .where('usuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) =>
            value.docs.map(DescarteModel.fromQueryDocSnapshot).toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Descartes'),
      ),
      body: ListView.builder(
        itemCount: discardList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(discardList[index]
                .usuarioId), // replace with your actual data field
            subtitle: Text(discardList[index].farmaciaId ??
                'No FarmaciaId'), // replace with your actual data field
          );
        },
      ),
    );
  }
}
