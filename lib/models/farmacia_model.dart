import 'package:cloud_firestore/cloud_firestore.dart';

class FarmaciaModel{
  late String id;
  late String cnpj;
  late GeoPoint localizacao;
  late String nome;

  FarmaciaModel.fromQueryDocSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> qds) {
    id = qds.id;
    Map data = qds.data();
    nome = data['nome'];
    localizacao = data['localizacao'];
  }
}