import 'package:cloud_firestore/cloud_firestore.dart';

class DescarteModel{
  late String id;
  late List descartes;
  String? farmaciaId;
  late String usuarioId;

  DescarteModel.fromQueryDocSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> qds) {
    id = qds.id;
    Map data = qds.data();
    farmaciaId = data['farmacia'];
    usuarioId = data['usuario'];
    descartes = data['descarte'];
  }
}